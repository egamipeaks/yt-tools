# yt-tools

CLI utilities for downloading and tagging audio/video from YouTube.

## Requirements

- [yt-dlp](https://github.com/yt-dlp/yt-dlp) - `brew install yt-dlp`
- [ffmpeg](https://ffmpeg.org/) - `brew install ffmpeg`
- [id3v2](https://id3v2.sourceforge.net/) - `brew install id3v2`

## Installation

```bash
git clone https://github.com/YOUR_USERNAME/yt-tools.git ~/.yt-tools
cd ~/.yt-tools
./install.sh
```

This creates symlinks in `~/.local/bin`. Make sure it's in your PATH:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

### Update

```bash
cd ~/.yt-tools
git pull
```

Scripts are symlinked, so updates are immediate.

### Uninstall

```bash
cd ~/.yt-tools
./install.sh uninstall
```

## Scripts

### ytmp3

Download a YouTube video as MP3 with metadata tagging.

```bash
ytmp3 <youtube-url> [custom-filename]
```

- Downloads audio as high-quality MP3
- Saves thumbnail and description
- Prompts for artist, album, year
- Embeds cover art

### ytmv

Download a YouTube video as MP4.

```bash
ytmv <youtube-url> [custom-name]
```

- Downloads best quality video+audio
- Merges to MP4 format
- Saves thumbnail and description

### ytalbum

Download a YouTube video as a full album MP3.

```bash
ytalbum <youtube-url> [artist] [album] [year]
```

- Designed for full album uploads
- Tags with artist/album/year
- Syncs to configured music directory

### tagmp3

Tag an existing MP3 file with ID3 metadata.

```bash
tagmp3 <path-to-mp3> [path-to-cover.jpg] [options]
```

Options:
- `--title "Song Title"`
- `--artist "Artist Name"`
- `--album "Album Name"`
- `--year "YYYY"`
- `--no-cover` - Skip cover art embedding
- `--no-prompt` - Don't prompt for missing fields

## Configuration

### ytalbum

Edit `bin/ytalbum` to change the destination directory:

```bash
DEST_ROOT="/Volumes/music_ssd/Music"
```

### ytmp3 / ytmv

Default output directories:
- ytmp3: `~/Soulseek Downloads/complete/`
- ytmv: `~/Soulseek Downloads/complete/videos/`

Edit the scripts to change these paths.

## License

MIT
