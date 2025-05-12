# 🎙️ Video to Text Transcription Web App

A simple and efficient **Flask web application** that accepts video uploads from a frontend, extracts audio, transcribes speech into text using **Whisper.cpp (ggml models)**, and displays the transcript back to the user.

Powered by **FFmpeg**, **Whisper.cpp**, **Flask**, and **Gunicorn** — containerized with **Docker**.

## 🚀 Live Demo

👉 [Try the Video to Text App](https://videototext-production.up.railway.app/)

---

## 🚀 Features
- ✅ Upload videos in any format (MP4, MKV, MOV, AVI, etc.)
- ✅ Extracts audio and converts to **WAV** using **FFmpeg**
- ✅ Transcribes speech using **OpenAI Whisper (cpp)**
- ✅ Displays transcript on frontend
- ✅ Production-ready with **Gunicorn** and **Docker**
- ✅ Easily deployable anywhere (VPS, Cloud, Localhost)

---

## 📸 Demo
![Demo GIF or Screenshot here]  
_(Add a gif showing video upload -> transcript result)_

---

## 🛠️ Tech Stack
| Tool        | Purpose                                       |
|-------------|-----------------------------------------------|
| **Flask**   | Web backend & routing                         |
| **Whisper.cpp** | Fast on-device speech transcription      |
| **FFmpeg**  | Extract audio from video files                |
| **Gunicorn**| Production WSGI HTTP server                   |
| **Docker**  | Containerized deployment                      |

---

## 📦 Installation & Setup

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/kalminx/video_to_text.git
cd video_to_text
````

### 2️⃣ Build & Run with Docker

```bash
docker build -t flask-whisper-gunicorn .
docker run -p 8000:8000 flask-whisper-gunicorn
```

### 3️⃣ Access the App

Go to: [http://localhost:8000](http://localhost:8000)

---

## 🗂️ Project Structure

```
/video-transcription-app/
├── app.py               # Flask application
├── process_video.sh     # Shell script: extract audio, transcribe
├── whisper.cpp/         # Cloned whisper.cpp (models, build)
├── templates/
│   ├── index.html       # Upload form
│   └── result.html      # Transcript display
├── uploads/             # Uploaded videos (gitignored)
├── output/              # Generated transcripts/audio (gitignored)
├── requirements.txt     # Python dependencies
├── Dockerfile           # Docker setup with Gunicorn
└── .gitignore           # Ignored files/folders
```

---

## ⚙️ How It Works

1. User uploads a video via frontend.
2. Flask saves the video to `/uploads/`.
3. `process_video.sh`:

   * Extracts audio from the video with FFmpeg.
   * Transcribes the audio using `whisper.cpp`.
   * Saves transcript to `/output/`.
4. Flask reads transcript and displays it on the frontend.

---

## 📝 Usage Example

```bash
# Upload a video via browser form
# Result: Transcript text displayed after processing
```

---

## ✅ To-Do & Improvements

* [ ] Progress bar for transcription
* [ ] Multi-language model support
* [ ] Save transcription history per user
* [ ] REST API version for integration

---

## 🧹 Clean Up Temporary Files

After each run, temporary files in `uploads/` and `output/` are automatically cleaned to save space.

---

## 🐳 Docker Compose (Optional)

For advanced deployment with NGINX reverse proxy, see \[docker-compose.yml] (coming soon).

---

## 🙏 Credits

* [OpenAI Whisper.cpp](https://github.com/ggerganov/whisper.cpp)
* [FFmpeg](https://ffmpeg.org/)
* Flask, Gunicorn, Docker

---

## 📄 License

MIT License - Feel free to use, modify, and share.

---

## ⭐️ Support This Project

If you found this helpful, give it a ⭐ on GitHub and consider contributing!

