import os
import subprocess
from flask import Flask, request, render_template, redirect, url_for
import logging
from pathlib import Path

app = Flask(__name__)
UPLOAD_FOLDER = 'uploads'
OUTPUT_FOLDER = 'output'
os.makedirs(UPLOAD_FOLDER, exist_ok=True)
os.makedirs(OUTPUT_FOLDER, exist_ok=True)

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        if 'video' not in request.files:
            return "No file part", 400

        file = request.files['video']
        if file.filename == '':
            return "No selected file", 400

        # Save uploaded video
        video_path = os.path.join(UPLOAD_FOLDER, file.filename)
        file.save(video_path)

        # Run process_video.sh
        try:
            result = subprocess.run(
                ['./process_video.sh', video_path],
                capture_output=True,
                text=True,
                check=True
            )
            output = result.stdout.strip()
            lines = output.splitlines()

            # Assuming last line is the transcript path
            transcript_file = lines[-1].strip()
            print("Transcript file: ", transcript_file)
            print("OS path exists: ", os.path.isfile(transcript_file))
        except subprocess.CalledProcessError as e:
            return f"Error from process: {e.stderr}", 500

        if not os.path.exists(transcript_file):
            return "Transcript file not found", 500

        with open(transcript_file, 'r') as f:
            transcript = f.read().strip()
            
       # ✅ Clean up files using subprocess (rm)
        try:
            subprocess.run(['rm', '-f', video_path], check=True)
            subprocess.run(['rm', '-f', transcript_file], check=True)

            # Also remove the generated WAV file if any
            audio_file = os.path.join(OUTPUT_FOLDER, 'class_audio.wav')
            if os.path.exists(audio_file):
                subprocess.run(['rm', '-f', audio_file], check=True)

        except subprocess.CalledProcessError as e:
            print(f"Cleanup failed: {e}")

        return render_template('result.html', transcript=transcript)

    return render_template('index.html')

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=8000)