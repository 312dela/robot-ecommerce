from datetime import datetime, timezone

def generate_email():
    timestamp = datetime.now(timezone.utc).strftime("%Y%m%d%H%M%S")
    return f"user{timestamp}@yopmail.com"  