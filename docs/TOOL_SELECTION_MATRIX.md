# Tool Selection Matrix

> Approved tool selections for ProjectClipsAI with alternatives and rationale.

| Function | Selected Tool | Alternative | Decision |
|----------|---------------|-------------|----------|
| Workflow Engine | ComfyUI | A1111, Forge | ComfyUI has native image-to-video node support and broader model compatibility for WAN/LTX |
| Video Generation | WAN | LTX | WAN delivers higher quality. LTX retained as experimental fallback |
| Image Generation | ComfyUI (built-in) | A1111, Forge | No separate tool needed. ComfyUI handles image gen natively within the same workflow |
| Video Assembly | FFmpeg | MoviePy, Shotcut | FFmpeg is scriptable, zero-GUI, and already confirmed working in environment checks |
| Prompt Generation | Cloud AI (ChatGPT / Claude) | Local LLM | Cloud AI offers higher quality for creative tasks. Local LLM deferred for future optimization |
| Environment Launcher | Stability Matrix | Pinokio, Manual | Stability Matrix provides one-click ComfyUI management, model path config, and version control |
| Subtitle Creation | Subtitle Edit (optional) | CapCut, Aegisub | Deferred. Not needed for first clip sprint |
| Sandbox Testing | Pinokio | — | For evaluating new models/tools in isolation. Not for production |
| Version Control | Git | — | Standard. Models and large assets excluded via .gitignore |

## Rationale Summary

- **ComfyUI over A1111/Forge**: ComfyUI's node graph natively supports chaining image generation → image-to-video → upscaling in a single workflow. A1111 requires separate tooling.
- **WAN over LTX**: WAN produces higher-fidelity video. LTX is retained because it uses less VRAM and renders faster — useful for iteration.
- **Stability Matrix over Pinokio**: Stability Matrix is purpose-built for ComfyUI management. Pinokio is a general launcher with broader but shallower support.
- **FFmpeg over GUI editors**: Scriptable, repeatable, and already verified working. No GUI dependency.
