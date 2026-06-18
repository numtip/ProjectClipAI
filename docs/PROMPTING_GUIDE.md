# Prompting Guide

## Standard Prompt Structure

Every prompt should include these fields:

| Field | Description | Required |
|-------|-------------|----------|
| Scene | Setting and environment | Yes |
| Subject | Main character/object | Yes |
| Style | Artistic style (cinematic, anime, realistic, etc.) | Yes |
| Camera | Camera angle, movement, framing | Yes |
| Lighting | Light source, mood, color temperature | Yes |
| Motion | Movement description (for video prompts) | For video |
| Negative | What to avoid | Recommended |
| Duration | Clip length in seconds | For video |
| Aspect Ratio | e.g., 16:9, 9:16, 1:1 | Yes |

## Image Prompt Template

```
Scene: [describe setting and background]
Subject: [describe main character/object]
Style: [art style, artist references, quality modifiers]
Camera: [angle, framing, shot type]
Lighting: [type, mood, color]
Negative: [undesired elements]
Aspect Ratio: [width:height]
```

## Video Motion Prompt Template

```
Scene: [describe setting]
Subject: [describe subject]
Style: [art style]
Camera: [camera movement]
Lighting: [lighting description]
Motion: [describe the motion/action in detail]
Negative: [undesired elements]
Duration: [seconds]
Aspect Ratio: [width:height]
```

## Tips

- Be specific about subject placement and movement
- For image-to-video, the prompt should describe what changes from the reference frame
- Keep negative prompts concise — focus on common artifacts (blurry, distorted, extra limbs)
- Reference artistic styles or cinematographers for consistent aesthetics
- Start with shorter prompts and add detail iteratively
