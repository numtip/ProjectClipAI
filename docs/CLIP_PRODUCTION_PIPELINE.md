# Clip Production Pipeline

## Stage 1: Planning

**Input:** Topic / Idea
**Output:** `projects/<id>/brief.md`

1. Define clip concept and duration
2. Identify models and workflows needed
3. Check registries for existing assets
4. Write project brief

## Stage 2: Script & Storyboard

**Input:** Project brief
**Output:** `projects/<id>/storyboard.md`

1. Write script (cloud AI)
2. Break into shots (max 3 for early projects)
3. Specify for each shot: scene, subject, style, camera, lighting, motion
4. Define duration per shot (5s starting constraint)

## Stage 3: Prompt Engineering

**Input:** Storyboard
**Output:** `projects/<id>/prompts.md`

1. Write image prompts using templates from `workflows/prompts/`
2. Write video motion prompts
3. Validate prompt structure (scene, subject, style, camera, lighting, motion, negative, duration, aspect ratio)

## Stage 4: Image Generation

**Input:** Image prompts
**Output:** Key images in `projects/<id>/assets/`

1. Load ComfyUI workflow
2. Generate key images for each shot
3. Review and iterate
4. Document settings in `render-notes.md`

## Stage 5: Video Generation

**Input:** Key images
**Output:** Raw clips in `projects/<id>/outputs/`

1. Load image-to-video workflow
2. Generate clips from key images
3. Review and iterate
4. Document settings in `render-notes.md`

## Stage 6: Assembly

**Input:** Raw clips
**Output:** Final MP4 in `projects/<id>/exports/`

1. Use FFmpeg to concatenate shots
2. Add transitions if needed
3. Sync audio if applicable
4. Export final MP4
5. Document in `render-notes.md`

## Stage 7: Review

**Input:** Final MP4
**Output:** Completed project entry in registry

1. Review final clip
2. Archive project in `registry/PROJECT_REGISTRY.md`
3. Note lessons learned in `render-notes.md`
