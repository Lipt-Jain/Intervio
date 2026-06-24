# Intervio (Intervio)

An interactive technical interviewing platform featuring live video calls, synchronized chat, and a collaborative code editor. Built with the MERN stack, Stream SDK, Clerk Authentication, and Piston API for code execution.

## Features
- **Live Video & Audio Calling**: Powered by Stream Video SDK.
- **Real-Time Chat**: Synchronized messaging via Stream Chat SDK.
- **Collaborative Code Editor**: Monaco Editor integration supporting multiple languages (JavaScript, Python, Java, etc.).
- **Code Execution**: Safe and secure code compilation using Piston API.
- **Authentication**: Secure user login and management via Clerk.
- **Event-Driven Architecture**: User syncing and background tasks managed by Inngest.

## Tech Stack
- **Frontend**: React, Vite, TailwindCSS, DaisyUI, React Query, Zustand
- **Backend**: Node.js, Express, MongoDB
- **Third-Party Services**: Stream (Video/Chat), Clerk (Auth), Inngest (Background Jobs), Piston (Code Execution)

## Getting Started

1. Clone the repository.
2. Setup environment variables for both \rontend\ and \ackend\.
3. Install dependencies:
   - \cd frontend && npm install\
   - \cd backend && npm install\
4. Start the servers:
   - \cd frontend && npm run dev\
   - \cd backend && npm run dev\

Enjoy interviewing!