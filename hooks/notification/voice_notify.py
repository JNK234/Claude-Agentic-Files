#!/usr/bin/env python3
"""
Batman-themed voice notifications for Claude Code using system TTS
Provides Master Wayne with audio updates from the Batcave
"""

import json
import sys
import subprocess
import platform

def speak(message):
    """Speak the message using system TTS"""
    system = platform.system()
    
    try:
        if system == "Darwin":  # macOS
            subprocess.run(["say", message])
        elif system == "Linux":
            # Try espeak first, then festival
            try:
                subprocess.run(["espeak", message], check=True)
            except:
                subprocess.run(["echo", message, "|", "festival", "--tts"], 
                             shell=True)
        elif system == "Windows":
            # Use PowerShell for Windows TTS
            ps_cmd = f'Add-Type -AssemblyName System.speech; ' \
                    f'$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer; ' \
                    f'$speak.Speak("{message}")'
            subprocess.run(["powershell", "-Command", ps_cmd])
    except:
        # Fallback to terminal bell if TTS fails
        print("\a")

def main():
    """Main entry point for the hook"""
    try:
        # Read notification from stdin
        notification = json.load(sys.stdin)
        
        message = notification.get("message", "")
        
        # Add Batman-themed personality to messages
        if "needs your input" in message.lower():
            speak("Master Wayne, the Batcave requires your attention.")
        elif "completed" in message.lower():
            speak("Master Wayne, mission accomplished. Gotham is secure.")
        elif "error" in message.lower():
            speak("Master Wayne, we've encountered a situation in the field.")
        elif "analyzing" in message.lower():
            speak("Master Wayne, running diagnostics from the Batcave.")
        elif "implementing" in message.lower():
            speak("Master Wayne, deploying Wayne Tech protocols.")
        elif "testing" in message.lower():
            speak("Master Wayne, running security validation systems.")
        else:
            speak(f"Master Wayne, {message}")
        
        # Always allow
        print(json.dumps({"action": "allow"}))
        
    except Exception as e:
        print(json.dumps({"action": "allow"}))

if __name__ == "__main__":
    main()