#!/bin/bash
set -e

# Usage instructions
if [ -z "$1" ]; then
  echo "Usage: $0 <video_file>"
  exit 1
fi

VIDEO_FILE="$1"
BASENAME=$(basename "$VIDEO_FILE")
FILENAME="${BASENAME%.*}"

# Output directories
OUTPUT_DIR="./output"
WHISPER_DIR="./whisper.cpp"
MODEL_SIZE="base.en"  # Change to tiny.en for faster dev testing

# Ensure output directory exists
mkdir -p "$OUTPUT_DIR"

# 1. Extract audio (WAV)
WAV_FILE="${OUTPUT_DIR}/${FILENAME}.wav"
echo "[INFO] Extracting audio to ${WAV_FILE}..."
ffmpeg -y -i "$VIDEO_FILE" -vn -acodec pcm_s16le -ar 44100 -ac 2 "$WAV_FILE"

# 2. Check whisper-cli binary
WHISPER_CLI="${WHISPER_DIR}/build/bin/whisper-cli"
if [ ! -f "$WHISPER_CLI" ]; then
  echo "[ERROR] whisper-cli binary not found. Build whisper.cpp first."
  exit 1
fi

# 3. Transcribe using whisper-cli
TRANSCRIPT_FILE="${OUTPUT_DIR}/${FILENAME}_transcript.txt"
echo "[INFO] Running Whisper.cpp transcription..."
"$WHISPER_CLI" -m "${WHISPER_DIR}/models/ggml-${MODEL_SIZE}.bin" -f "$WAV_FILE" > "$TRANSCRIPT_FILE" "$WHISPER_CLI" -m "${WHISPER_DIR}/models/ggml-${MODEL_SIZE}.bin" -f "$WAV_FILE" > "$TRANSCRIPT_FILE" 2>/dev/null

echo "[INFO] Transcription saved to ${TRANSCRIPT_FILE}"

# 4. Output transcript file path
echo "$TRANSCRIPT_FILE"

