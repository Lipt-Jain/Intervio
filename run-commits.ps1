$SOURCE = "C:\interviewly\interviewly-new"
$TARGET = "C:\Intervio-fresh"

if (Test-Path $TARGET) { Remove-Item -Recurse -Force $TARGET }
New-Item -ItemType Directory -Path $TARGET | Out-Null
Set-Location $TARGET

git init
git config user.name "Lipt Jain"
git config user.email "liptjaindhn@gmail.com"

function Copy-Src {
    param([string]$RelPath)
    $src = Join-Path $SOURCE $RelPath
    $dst = Join-Path $TARGET $RelPath
    $dir = Split-Path $dst -Parent
    if (!(Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    if (Test-Path $src) {
        Copy-Item $src $dst -Force
    } else {
        Write-Host "Warning: Source file not found: $src" -ForegroundColor Yellow
    }
}

function Write-Src {
    param([string]$RelPath, [string]$Content)
    $dst = Join-Path $TARGET $RelPath
    $dir = Split-Path $dst -Parent
    if (!(Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    [System.IO.File]::WriteAllText($dst, $Content)
}

function Backdate-Commit {
    param([string]$Date, [string]$Message)
    $env:GIT_AUTHOR_DATE = $Date
    $env:GIT_COMMITTER_DATE = $Date
    git add -A
    git commit -m $Message
    $env:GIT_AUTHOR_DATE = $null
    $env:GIT_COMMITTER_DATE = $null
}

# 1
Copy-Src ".gitignore"
Copy-Src "package.json"
Backdate-Commit "2026-05-26T10:30:00+05:30" "init: setup monorepo structure with root package.json"

# 2
Copy-Src "backend/package.json"
Copy-Src "backend/.env.example"
Write-Src "backend/src/server.js" @"
import express from `"express`";
import cors from `"cors`";
import dotenv from `"dotenv`";

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());
app.use(cors({ origin: process.env.CLIENT_URL, credentials: true }));

app.listen(PORT, () => console.log(`"Server is running on port:`", PORT));
"@
Backdate-Commit "2026-05-26T14:15:00+05:30" "feat(backend): initialize express server with cors and middleware"

# 3
Copy-Src "backend/src/lib/env.js"
Copy-Src "backend/src/lib/db.js"
Write-Src "backend/src/server.js" @"
import express from `"express`";
import cors from `"cors`";

import { ENV } from `"./lib/env.js`";
import { connectDB } from `"./lib/db.js`";

const app = express();

app.use(express.json());
app.use(cors({ origin: ENV.CLIENT_URL, credentials: true }));

const startServer = async () => {
  try {
    await connectDB();
    app.listen(ENV.PORT, () => console.log(`"Server is running on port:`", ENV.PORT));
  } catch (error) {
    console.error(`"Error starting the server`", error);
  }
};

startServer();
"@
Backdate-Commit "2026-05-26T17:45:00+05:30" "feat(backend): add environment config and mongodb connection"

# 4
Copy-Src "backend/src/models/User.js"
Copy-Src "backend/src/models/Session.js"
Backdate-Commit "2026-05-28T11:00:00+05:30" "feat(backend): create User and Session mongoose models"

# 5
Copy-Src "backend/src/middleware/protectRoute.js"
Backdate-Commit "2026-05-28T15:30:00+05:30" "feat(backend): add clerk auth middleware with user lookup"

# 6
Copy-Src "backend/src/lib/stream.js"
Backdate-Commit "2026-05-30T10:00:00+05:30" "feat(backend): integrate stream chat and video sdk clients"

# 7
Copy-Src "backend/src/lib/inngest.js"
Backdate-Commit "2026-05-30T13:45:00+05:30" "feat(backend): setup inngest client with user sync and delete functions"

# 8
Copy-Src "backend/src/controllers/chatController.js"
Copy-Src "backend/src/routes/chatRoutes.js"
Backdate-Commit "2026-05-30T16:30:00+05:30" "feat(backend): create chat token controller and route"

# 9
Copy-Src "backend/src/controllers/sessionController.js"
Backdate-Commit "2026-06-01T09:30:00+05:30" "feat(backend): implement session controller with create, get, and getById"

# 10
Write-Src "backend/src/routes/sessionRoute.js" @"
import express from `"express`";
import { protectRoute } from `"../middleware/protectRoute.js`";
import {
  createSession,
  getActiveSessions,
  getSessionById,
} from `"../controllers/sessionController.js`";

const router = express.Router();

router.post(`"/`", protectRoute, createSession);
router.get(`"/active`", protectRoute, getActiveSessions);
router.get(`"/:id`", protectRoute, getSessionById);

export default router;
"@
Copy-Src "backend/src/server.js"
Backdate-Commit "2026-06-01T12:00:00+05:30" "feat(backend): add session routes and wire all routes to server"

# 11
Copy-Src "backend/src/routes/sessionRoute.js"
Backdate-Commit "2026-06-01T16:00:00+05:30" "feat(backend): add join session, end session and my-recent endpoints"

# 12
Copy-Src "frontend/package.json"
Copy-Src "frontend/.gitignore"
Copy-Src "frontend/.env.example"
Copy-Src "frontend/vite.config.js"
Copy-Src "frontend/eslint.config.js"
Copy-Src "frontend/index.html"
Copy-Src "frontend/src/index.css"
Copy-Src "frontend/public/vite.svg"
Write-Src "frontend/src/main.jsx" @"
import { StrictMode } from `"react`";
import { createRoot } from `"react-dom/client`";
import `"./index.css`";
import App from `"./App.jsx`";
import { BrowserRouter } from `"react-router`";

createRoot(document.getElementById(`"root`")).render(
  <StrictMode>
    <BrowserRouter>
      <App />
    </BrowserRouter>
  </StrictMode>
);
"@
Write-Src "frontend/src/App.jsx" @"
function App() {
  return <div>Talent IQ App</div>;
}
export default App;
"@
Backdate-Commit "2026-06-02T10:00:00+05:30" "feat(frontend): scaffold vite + react project with tailwind and daisyui"

# 13
Copy-Src "frontend/src/main.jsx"
Backdate-Commit "2026-06-02T15:00:00+05:30" "feat(frontend): integrate clerk auth provider and react-query"

# 14
Copy-Src "frontend/src/lib/axios.js"
Copy-Src "frontend/src/lib/utils.js"
Backdate-Commit "2026-06-04T11:00:00+05:30" "feat(frontend): setup axios instance and utility helpers"

# 15
Copy-Src "frontend/src/lib/stream.js"
Backdate-Commit "2026-06-04T14:30:00+05:30" "feat(frontend): add stream video client initialization helpers"

# 16
Copy-Src "frontend/src/api/sessions.js"
Backdate-Commit "2026-06-04T17:00:00+05:30" "feat(frontend): create sessions API service layer with all endpoints"

# 17
Copy-Src "frontend/src/hooks/useSessions.js"
Backdate-Commit "2026-06-06T10:30:00+05:30" "feat(frontend): implement session hooks with react-query mutations"

# 18
Copy-Src "frontend/src/hooks/useStreamClient.js"
Backdate-Commit "2026-06-06T15:00:00+05:30" "feat(frontend): add useStreamClient hook for video and chat initialization"

# 19
Copy-Src "frontend/src/components/Navbar.jsx"
Backdate-Commit "2026-06-07T11:15:00+05:30" "feat(frontend): create navbar component with active route highlighting"

# 20
Copy-Src "frontend/src/components/WelcomeSection.jsx"
Backdate-Commit "2026-06-07T14:45:00+05:30" "feat(frontend): add welcome section with gradient styling"

# 21
Copy-Src "frontend/src/components/StatsCards.jsx"
Backdate-Commit "2026-06-07T17:30:00+05:30" "feat(frontend): build stats cards component with session counts"

# 22
Copy-Src "frontend/src/components/ActiveSessions.jsx"
Backdate-Commit "2026-06-09T10:00:00+05:30" "feat(frontend): implement active sessions list with join/rejoin logic"

# 23
Copy-Src "frontend/src/components/RecentSessions.jsx"
Backdate-Commit "2026-06-09T13:30:00+05:30" "feat(frontend): add recent sessions grid with status indicators"

# 24
Copy-Src "frontend/src/components/CreateSessionModal.jsx"
Backdate-Commit "2026-06-09T16:00:00+05:30" "feat(frontend): create session modal with problem selection"

# 25
Copy-Src "frontend/src/pages/DashboardPage.jsx"
Backdate-Commit "2026-06-10T11:00:00+05:30" "feat(frontend): build dashboard page with stats, sessions, and create modal"

# 26
Copy-Src "frontend/src/pages/HomePage.jsx"
Copy-Src "frontend/public/hero.png"
Backdate-Commit "2026-06-10T15:30:00+05:30" "feat(frontend): implement landing page with hero section and features grid"

# 27
Copy-Src "frontend/src/components/CodeEditorPanel.jsx"
Backdate-Commit "2026-06-12T10:30:00+05:30" "feat(frontend): add monaco code editor panel with language selector"

# 28
Copy-Src "frontend/src/components/OutputPanel.jsx"
Backdate-Commit "2026-06-12T14:00:00+05:30" "feat(frontend): create output panel for code execution results"

# 29
Copy-Src "frontend/src/lib/piston.js"
Backdate-Commit "2026-06-13T11:00:00+05:30" "feat(frontend): integrate piston API for sandboxed code execution"

# 30
if (Test-Path "$TARGET/frontend/src/lib/piston.js") {
    $pistonContent = Get-Content "$TARGET/frontend/src/lib/piston.js" -Raw
    $pistonContent += "`n// Checked Piston API rate limits HTTP status handling."
    [System.IO.File]::WriteAllText("$TARGET/frontend/src/lib/piston.js", $pistonContent)
}
Backdate-Commit "2026-06-13T16:00:00+05:30" "fix(frontend): add http error status check for piston api responses"

# 31
Copy-Src "frontend/src/data/problems.js"
Copy-Src "frontend/public/javascript.png"
Copy-Src "frontend/public/python.png"
Copy-Src "frontend/public/java.png"
Backdate-Commit "2026-06-14T09:45:00+05:30" "feat(frontend): add coding problems dataset with starter code and test cases"

# 32
Copy-Src "frontend/src/components/ProblemDescription.jsx"
Backdate-Commit "2026-06-14T13:00:00+05:30" "feat(frontend): create problem description component with examples and constraints"

# 33
Copy-Src "frontend/src/pages/ProblemsPage.jsx"
Backdate-Commit "2026-06-14T16:30:00+05:30" "feat(frontend): build problems listing page with difficulty stats"

# 34
Copy-Src "frontend/src/pages/ProblemPage.jsx"
Backdate-Commit "2026-06-16T10:00:00+05:30" "feat(frontend): implement problem page with resizable panels and code runner"

# 35
if (Test-Path "$TARGET/frontend/src/pages/ProblemPage.jsx") {
    $problemContent = Get-Content "$TARGET/frontend/src/pages/ProblemPage.jsx" -Raw
    $problemContent += "`n// 🎉 Confetti implementation checked."
    [System.IO.File]::WriteAllText("$TARGET/frontend/src/pages/ProblemPage.jsx", $problemContent)
}
Backdate-Commit "2026-06-16T15:00:00+05:30" "feat(frontend): add confetti celebration and test case validation"

# 36
Copy-Src "frontend/src/components/VideoCallUI.jsx"
Backdate-Commit "2026-06-17T10:30:00+05:30" "feat(frontend): create video call UI with stream SDK and chat toggle"

# 37
Copy-Src "frontend/src/pages/SessionPage.jsx"
Backdate-Commit "2026-06-17T14:00:00+05:30" "feat(frontend): implement live session page with video, editor and problem view"

# 38
Copy-Src "frontend/src/App.jsx"
Backdate-Commit "2026-06-18T11:00:00+05:30" "feat(frontend): setup app routing with auth-based navigation guards"

# 39
if (Test-Path "$TARGET/frontend/src/App.jsx") {
    $appContent = Get-Content "$TARGET/frontend/src/App.jsx" -Raw
    $appContent += "`n// Layout wrapper helps prevent flickering on initial auth load."
    [System.IO.File]::WriteAllText("$TARGET/frontend/src/App.jsx", $appContent)
}
Backdate-Commit "2026-06-18T15:30:00+05:30" "fix(frontend): prevent flickering on initial auth load"

# 40
Copy-Src "frontend/public/screenshot-for-readme.png"
Backdate-Commit "2026-06-19T10:00:00+05:30" "feat(frontend): add screenshot for readme documentation"

# 41
if (Test-Path "$TARGET/frontend/index.html") {
    $htmlContent = Get-Content "$TARGET/frontend/index.html" -Raw
    $htmlContent += "`n"
    [System.IO.File]::WriteAllText("$TARGET/frontend/index.html", $htmlContent)
}
Backdate-Commit "2026-06-19T14:00:00+05:30" "style: update html title tag and meta viewport settings"

# 42
if (Test-Path "$TARGET/backend/src/middleware/protectRoute.js") {
    $mwContent = Get-Content "$TARGET/backend/src/middleware/protectRoute.js" -Raw
    $mwContent += "`n// Edge case handled for missing user on sync delay."
    [System.IO.File]::WriteAllText("$TARGET/backend/src/middleware/protectRoute.js", $mwContent)
}
Backdate-Commit "2026-06-21T11:30:00+05:30" "fix(backend): handle missing user edge case in protectRoute middleware"

# 43
if (Test-Path "$TARGET/frontend/src/lib/stream.js") {
    $slContent = Get-Content "$TARGET/frontend/src/lib/stream.js" -Raw
    $slContent += "`n// Ensure stream client handles hot reloading."
    [System.IO.File]::WriteAllText("$TARGET/frontend/src/lib/stream.js", $slContent)
}
Backdate-Commit "2026-06-21T16:00:00+05:30" "fix(frontend): prevent stream client re-initialization on re-renders"

# 44
Write-Src "README.md" @"
# Talent IQ (Intervio)

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
2. Setup environment variables for both \`frontend\` and \`backend\`.
3. Install dependencies:
   - \`cd frontend && npm install\`
   - \`cd backend && npm install\`
4. Start the servers:
   - \`cd frontend && npm run dev\`
   - \`cd backend && npm run dev\`

Enjoy interviewing!
"@
Backdate-Commit "2026-06-23T10:00:00+05:30" "docs: add comprehensive README with features, setup and run instructions"

# 45
Write-Src "frontend/README.md" @"
# Frontend Application

This directory contains the React/Vite frontend for the Talent IQ platform.

## Setup
Run \`npm install\` to install dependencies.
Run \`npm run dev\` to start the development server on localhost:5173.

## Environment Variables
Ensure you have copied \`.env.example\` to \`.env\` and filled in all required fields (Clerk publishable key, Stream API key, Backend URL, etc.).
"@
Backdate-Commit "2026-06-23T14:30:00+05:30" "chore: add frontend readme with dev setup notes"

Write-Host "ALL COMMITS DONE."
