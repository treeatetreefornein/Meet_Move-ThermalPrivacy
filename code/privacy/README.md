# Video Anonimisation

# Gebruik
* Flags en hun argumenten worden getoond als geen input gegeven is.

# Issues
* Anonimiseringsmethoden worden in vaste (potentieel niet optimale) volgorde uitgevoerd
* Commandline input 
    * Accepteerd substrings van een argument (b.v. `--disp 0` wordt gezien als `--display 0`)
    * Flags parsen altijd de input die volgt, mocht een argument missen, dan kan de volgende flag als dit argument genomen worden
