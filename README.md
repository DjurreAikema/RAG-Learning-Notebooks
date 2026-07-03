# 🦙 Local RAG Q&A Chatbot

A fully **local** question-answering chatbot that answers using your own company documents.
Everything runs on your machine — the LLM, the embeddings, and the vector database — so no data
leaves your computer and there are no API costs.

**Stack:** [Ollama](https://ollama.com) · [LangChain](https://python.langchain.com) ·
[Chroma](https://www.trychroma.com) · Jupyter

---

## How it works (RAG in a nutshell)

```
Your docs → load → split → embed → store in Chroma        (indexing, done once)
Your question → retrieve relevant chunks → add to prompt → LLM writes a grounded answer
```

RAG = **R**etrieval **A**ugmented **G**eneration. Instead of relying only on what the model was
trained on, we retrieve the most relevant pieces of *your* documents and give them to the model as
context. The step-by-step notebook explains each stage.

---

## Setup (Windows)

### 1. Install Ollama
Download the Windows installer from <https://ollama.com/download> and run it. When it's running
you'll see a llama icon in your system tray. Ollama runs a local server at `http://localhost:11434`.

### 2. Pull the models
Open **PowerShell** (or Command Prompt) and run:

```powershell
ollama pull llama3.1:8b       # the chat model that writes answers
ollama pull nomic-embed-text  # the embedding model
```

> Your RTX 3050 + 64 GB RAM handles `llama3.1:8b` comfortably. If answers feel slow, try the smaller
> `llama3.2:3b`. For higher quality (and slower responses), try `qwen2.5:14b`.

### 3. Set up Python
Install Python 3.10+ from <https://python.org> if you don't have it (tick **"Add Python to PATH"**
during install). Then, in the project folder:

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1      # activates the virtual environment
pip install -r requirements.txt
```

> If PowerShell blocks the activate script, run once:
> `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` and try again.

### 4. Add your documents
Put your PDF / Word / text / Markdown files into the `data/` folder. A sample file is already there
so the notebook works immediately.

### 5. Launch the notebook
```powershell
jupyter notebook
```
Open `notebooks/local_rag_qa_bot.ipynb` and run the cells top to bottom.

---

## Do I need Docker?

**No — not for this project.** Ollama runs natively on Windows and Jupyter runs locally, so Docker
would just add complexity. Docker becomes worth it later if you want to *deploy* this or guarantee an
identical environment for someone else. It's listed as a stretch goal in the notebook.

---

## Project structure

```
rag-qa-bot/
├── README.md                          ← you are here
├── requirements.txt                   ← Python dependencies
├── .gitignore                         ← keeps venv / DB / private docs out of git
├── data/                              ← your company documents go here
│   └── sample_company_handbook.md     ← sample so it runs out of the box
└── notebooks/
    └── local_rag_qa_bot.ipynb         ← the step-by-step tutorial notebook
```

---

## Putting this on GitHub

```powershell
git init
git add .
git commit -m "Initial commit: local RAG Q&A chatbot"
```

Then create an empty repository on GitHub (no README/license, since you already have them) and:

```powershell
git remote add origin https://github.com/YOUR_USERNAME/rag-qa-bot.git
git branch -M main
git push -u origin main
```

> The `.gitignore` already excludes your virtual environment, the `chroma_db/` vector database, and
> your real documents in `data/` (everything except the sample). Confirm nothing confidential is
> staged with `git status` before your first push.

---

## Troubleshooting

| Symptom | Fix |
|---|---|
| `Could not reach Ollama` | Make sure the Ollama app is running (llama icon in tray). |
| Model "not found" | Re-run the `ollama pull ...` commands. |
| First run is very slow | Normal — embedding all chunks happens once, then it's cached in `chroma_db/`. |
| Answers say "I don't know" | Your question may not be covered by the docs, or retrieval missed it — try rephrasing or increasing `N_RESULTS`. |
| Changed your documents | Delete the `chroma_db/` folder and re-run Steps 3–5 to re-index. |
