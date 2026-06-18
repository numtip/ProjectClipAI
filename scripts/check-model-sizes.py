"""
Check file size of LTX-2.3 model from HuggingFace without downloading.
"""
import os
from huggingface_hub import hf_hub_download

# We can get the metadata without downloading the actual file
try:
    # Use the snapshot_download with dry run approach
    from huggingface_hub import get_hf_file_metadata, HfFileSystem
    
    # Alternative: use requests to check the file
    import requests
    url = "https://huggingface.co/Lightricks/LTX-2.3/resolve/main/ltx-2.3-22b-distilled-1.1.safetensors"
    
    # Send HEAD request to get content-length
    resp = requests.head(url, allow_redirects=True, timeout=10)
    if resp.status_code == 200:
        size = int(resp.headers.get('content-length', 0))
        print(f"ltx-2.3-22b-distilled-1.1.safetensors: {size / (1024**3):.1f} GB")
        print(f"Size in bytes: {size}")
    else:
        print(f"HEAD request returned: {resp.status_code}")
    
    # Also check non-1.1 version
    url2 = "https://huggingface.co/Lightricks/LTX-2.3/resolve/main/ltx-2.3-22b-distilled.safetensors"
    resp2 = requests.head(url2, allow_redirects=True, timeout=10)
    if resp2.status_code == 200:
        size2 = int(resp2.headers.get('content-length', 0))
        print(f"ltx-2.3-22b-distilled.safetensors: {size2 / (1024**3):.1f} GB")
        
except Exception as e:
    print(f"Error: {e}")
    import traceback
    traceback.print_exc()
