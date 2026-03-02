### Quick Fix vs Comprehensive Analysis Check
Before diving into extensive codebase exploration, planning mode, or creating elaborate implementation plans, determine whether the user needs a quick fix or comprehensive analysis:

**Quick Fix Indicators** (implement directly, skip planning):
- Configuration file changes (keyboard shortcuts, tool configs, air.toml, etc.)
- Simple bug fixes with clear error messages
- Typos, syntax errors, or small adjustments
- Straightforward debugging of known issues
- User explicitly says "quick fix" or "skip planning"

**Comprehensive Analysis Indicators** (use planning mode, explore thoroughly):
- New feature implementation across multiple files
- Architectural changes or refactoring
- API redesign or breaking changes
- Complex multi-step workflows
- User asks for "design", "plan", or "architecture"

**When uncertain, ask explicitly:**
```
Is this a quick configuration fix you need, or would you like me to do a comprehensive analysis and create a detailed plan? I'll adjust my approach accordingly.
```

This prevents over-engineering simple tasks while ensuring proper planning for complex changes.
