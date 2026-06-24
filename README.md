<div align="center">

# 🎯 Intervio

### An Interactive Technical Interviewing Platform

Live video calls, real-time chat, and a collaborative code editor — all in one place.
Built for engineers who interview engineers.

[![MERN](https://img.shields.io/badge/Stack-MERN-47A248?style=flat-square&logo=mongodb&logoColor=white)](#tech-stack)
[![React](https://img.shields.io/badge/Frontend-React-61DAFB?style=flat-square&logo=react&logoColor=white)](#tech-stack)
[![Node.js](https://img.shields.io/badge/Backend-Node.js-339933?style=flat-square&logo=node.js&logoColor=white)](#tech-stack)
[![Stream](https://img.shields.io/badge/Realtime-Stream-005FFF?style=flat-square)](#tech-stack)
[![Clerk](https://img.shields.io/badge/Auth-Clerk-6C47FF?style=flat-square)](#tech-stack)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](LICENSE)

[Features](#-features) • [Tech Stack](#-tech-stack) • [Getting Started](#-getting-started) • [Environment Variables](#-environment-variables) • [Project Structure](#-project-structure)

</div>

---

## 📖 Overview

**Intervio** is a full-stack technical interviewing platform that brings together everything a remote coding interview needs — face-to-face video, synchronized chat, and a shared code editor with live execution — without juggling four different tools.

Interviewers can launch a call, watch candidates write code in real time, and run that code on the spot, while every message and edit stays in sync across both ends of the call.

---

## ✨ Features

| | |
|---|---|
| 🎥 **Live Video & Audio Calling** | Peer-to-peer interview calls powered by the **Stream Video SDK**, with support for multiple participants. |
| 💬 **Real-Time Chat** | Synchronized messaging alongside the call via the **Stream Chat SDK** — share links, notes, or follow-up questions without breaking flow. |
| 🧑‍💻 **Collaborative Code Editor** | A **Monaco Editor** (the engine behind VS Code) integration with multi-language support — JavaScript, Python, Java, and more. |
| ⚡ **Live Code Execution** | Run candidate code safely in an isolated sandbox using the **Piston API** — no local setup, no security risk. |
| 🔐 **Secure Authentication** | User sign-up, sign-in, and session management handled end-to-end by **Clerk**. |
| 🔄 **Event-Driven Background Jobs** | User syncing and other async workflows orchestrated with **Inngest**, decoupled from the main request/response cycle. |

---

## 🛠 Tech Stack

**Frontend**
- React + Vite
- TailwindCSS + DaisyUI
- React Query — server state & caching
- Zustand — lightweight client state

**Backend**
- Node.js + Express
- MongoDB (with Mongoose)

**Third-Party Services**
- **Stream** — Video & Chat infrastructure
- **Clerk** — Authentication & user management
- **Inngest** — Background jobs & event-driven workflows
- **Piston** — Remote code execution engine

---

## 🏗 Architecture

```
┌─────────────────┐        REST / WebSocket        ┌──────────────────┐
│   React Client   │ ◄─────────────────────────────► │  Express Server  │
│  (Vite + Zustand) │                                 │   (Node.js)       │
└────────┬─────────┘                                 └────────┬─────────┘
         │                                                     │
         ├── Stream Video SDK ──► Stream.io (Video/Chat)        │
         ├── Monaco Editor ──────► Piston API (Code Execution)  │
         ├── Clerk SDK ───────────► Clerk (Auth)                │
         │                                                      │
         └──────────────────────────────────────────────► MongoDB
                                                            ▲
                                                            │
                                                      Inngest (Background Jobs)
```

---

## 🚀 Getting Started

### Prerequisites
- **Node.js** (v18 or higher recommended)
- **MongoDB** instance (local or Atlas)
- API keys for **Stream**, **Clerk**, and **Inngest**

### 1. Clone the repository

```bash
git clone https://github.com/<your-username>/intervio.git
cd intervio
```

### 2. Set up environment variables

Create a `.env` file in both `frontend/` and `backend/` — see [Environment Variables](#-environment-variables) below for the full list.

### 3. Install dependencies

```bash
# Frontend
cd frontend
npm install

# Backend
cd ../backend
npm install
```

### 4. Run the development servers

```bash
# In frontend/
npm run dev

# In backend/ (separate terminal)
npm run dev
```

The frontend will typically be available at `http://localhost:5173` and the backend at `http://localhost:5000` (confirm against your own `vite.config` / `.env` ports).

---

## 🔑 Environment Variables

**`backend/.env`**

```env
PORT=5000
MONGO_URI=your_mongodb_connection_string
CLERK_SECRET_KEY=your_clerk_secret_key
STREAM_API_KEY=your_stream_api_key
STREAM_API_SECRET=your_stream_api_secret
INNGEST_EVENT_KEY=your_inngest_event_key
INNGEST_SIGNING_KEY=your_inngest_signing_key
```

**`frontend/.env`**

```env
VITE_CLERK_PUBLISHABLE_KEY=your_clerk_publishable_key
VITE_STREAM_API_KEY=your_stream_api_key
VITE_API_BASE_URL=http://localhost:5000
```

> ⚠️ Never commit your `.env` files. Make sure both are listed in `.gitignore`.

---

## 📁 Project Structure

```
intervio/
├── frontend/
│   ├── src/
│   │   ├── components/      # Reusable UI components
│   │   ├── pages/           # Route-level views
│   │   ├── store/           # Zustand stores
│   │   ├── hooks/           # Custom React Query hooks
│   │   └── lib/             # Stream / Clerk client setup
│   └── package.json
│
├── backend/
│   ├── src/
│   │   ├── routes/          # Express route definitions
│   │   ├── controllers/     # Request handlers
│   │   ├── models/          # Mongoose schemas
│   │   ├── inngest/         # Background job functions
│   │   └── config/          # DB, Stream, Clerk config
│   └── package.json
│
└── README.md
```

---

## 🗺 Roadmap

- [ ] Interview recording & playback
- [ ] Whiteboard / system-design canvas
- [ ] Built-in question bank & rubric scoring
- [ ] Multi-interviewer support

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

1. Fork the project
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

<div align="center">

Built with ❤️ for better technical interviews.

**Enjoy interviewing! 🎯**

</div>
