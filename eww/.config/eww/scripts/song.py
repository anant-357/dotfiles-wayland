
import dbus
import sys
import json
import requests
import os

default = {"title": "", "artist": "", "status": "󰝚"}

def get_mpris_metadata():
    try:
        session_bus = dbus.SessionBus()
        player_names = [name for name in session_bus.list_names() if name.startswith('org.mpris.MediaPlayer2.sp')]
        
        if not player_names:
            return default
        
        player = session_bus.get_object(player_names[0], "/org/mpris/MediaPlayer2")
        interface = dbus.Interface(player, dbus_interface="org.freedesktop.DBus.Properties")
        metadata = interface.Get("org.mpris.MediaPlayer2.Player", "Metadata")
        playback_status = interface.Get("org.mpris.MediaPlayer2.Player", "PlaybackStatus")
        
        title = metadata.get('xesam:title', "Unknown Title")
        artist = metadata.get('xesam:artist', ["Unknown Artist"])[0]
        cover_url = metadata.get('mpris:artUrl', "Unknown Cover")
        cover_path = ""
        
        if cover_url and cover_url.startswith("http"):
            cover_path = "cover.jpg"
            try:
                response = requests.get(cover_url, stream=True)
                if response.status_code == 200:
                    with open(cover_path, 'wb') as f:
                        for chunk in response.iter_content(1024):
                            f.write(chunk)
            except Exception as e:
                cover_path = ""

        status = ""

        if playback_status == "Paused":
            status = "󰐊"
        elif playback_status == "Playing":
            status = "󰏤"
        else:
            status = "󰓛"
        
        return {"title": title, "artist": artist, "status": status, "player_name": player_names[0], "cover": cover_path}
    except Exception as e:
        return default

def control_player(action, player_name):
    session_bus = dbus.SessionBus()
    player = session_bus.get_object(player_name, "/org/mpris/MediaPlayer2")
    interface = dbus.Interface(player, dbus_interface="org.mpris.MediaPlayer2.Player")
    
    if action == "toggle":
        interface.PlayPause()
    elif action == "next":
        interface.Next()
    elif action == "prev":
        interface.Previous()

if __name__ == "__main__":
    result = get_mpris_metadata()
    if result:
        print(json.dumps(result))
        
        if len(sys.argv) > 1:
            control_player(sys.argv[1], result["player_name"])
