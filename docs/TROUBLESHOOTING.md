# Troubleshooting Guide

## CUDA Issues

**Problem:** ComfyUI won't start or CUDA error
- Verify NVIDIA driver is installed and up to date
- Check CUDA version compatibility with PyTorch
- Run `nvidia-smi` to confirm GPU is detected
- Update PyTorch via ComfyUI manager if needed

## VRAM Errors

**Problem:** Out of memory during generation
- Reduce batch size
- Lower resolution (try 512x512 or 720p instead of 1080p)
- Use a smaller model
- Close other GPU-using applications
- Enable --lowvram mode in ComfyUI

## Missing Models

**Problem:** "Model not found" error in ComfyUI
- Check `registry/MODEL_REGISTRY.md` for the model's external path
- Verify model file exists at the expected location
- Check Stability Matrix model path configuration
- Download the model if it's missing (do not commit to Git)

## Missing FFmpeg

**Problem:** FFmpeg-related errors in ComfyUI or scripts
- Run `scripts/ffmpeg-check.ps1` to diagnose
- Install FFmpeg and add to PATH
- Restart ComfyUI after installation
- Verify with `ffmpeg -version`

## Slow Rendering

**Problem:** Generation takes too long
- Monitor GPU usage with `nvidia-smi -l`
- Check if system is using integrated GPU instead of NVIDIA
- Reduce output resolution
- Consider model optimizations (TensorRT, ONNX)
- For video models, reduce frame count

## Flickering

**Problem:** Visible flickering between frames in video output
- Increase frame count for smoother transitions
- Use frame interpolation
- Check if denoising strength is appropriate
- Try different video model settings

## Character Inconsistency

**Problem:** Character appearance changes between shots
- Use a consistent seed across generations
- Keep prompt descriptions consistent for the character
- Consider using a reference image for each shot
- Document which settings worked for future reference
