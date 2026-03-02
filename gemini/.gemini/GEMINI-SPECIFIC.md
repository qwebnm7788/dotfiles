### Gemini-Specific Instructions

## Jules Extension Usage
- **Offload Strategy:** If a task involves more than 5-10 files or is expected to take significant time (e.g., adding comprehensive tests, project-wide refactoring), proactively suggest using the `/jules` extension.
- **Background Tasks:** Always use Jules for non-interactive tasks like dependency upgrades, linting the entire codebase, or generating documentation for all modules.
- **Workflow:** When a Jules task is initiated, provide the user with the status tracking command and the web console link.
