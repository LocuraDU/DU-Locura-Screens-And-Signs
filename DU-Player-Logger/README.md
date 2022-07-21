# Elements Needed
- 1x Programming board
- 1x Manual Switch
- 1x Screen
- 1x Detection zone
- 1 to 8 Databank(s)

# Install
- Copy the content of this link
- Right click (on the programming board) -> Advanced -> Paste Lua configuration from clipboard
- Connect Detection zone -> Manual Switch -> Programming Board -> Manual Switch (both way)
- For multiple detection zone: add an "OR operator" between the Detection zones and the Manual Switch
- (only 1 needed) in between the zones and switch
- Then Programming Board -> databank(s) and screen
- Finnaly, hit ctrl+L while looking at the board
- add your username in line 7 of unit.start()
- rename the location to your liking
- Activate the board manualy and type "help" in the lua chat for the command list

# Preview
*Actual LUA is animated
![Image of Screen](DU-Wave-Text.png?raw=true)

# Help Commands
- 'clear' [clear the databank(s)]
- 'dump' [dump the table as JSON in the screen HTML so you can copy it]
- 'exit' [exit debug mode]
- 'help' display a list of commands
- 'remove (indices)' [remove an entry from one of the table]
- 'update' [Update the screen code]
