# Makefile for creating Hamster Dance sound from Robin Hood (1973) intro
# Usage: make hamster_dance.mp3

# Variables
SOURCE_MP3 = robinhood_intro.mp3
TEMP_CLIP = temp_clip.mp3
OUTPUT = hamster_dance.mp3
START_TIME = 00:00:30
END_TIME = 00:00:45
PITCH_FACTOR = 1.7
TEMPO_ADJUST = 0.97
SAMPLE_RATE = 44100

# Default target
all: $(OUTPUT)
	@echo "Hamster Dance clip created successfully!"

# Create the hamster dance clip
$(OUTPUT): $(TEMP_CLIP)
	ffmpeg -i $(TEMP_CLIP) -filter_complex "asetrate=$(SAMPLE_RATE)*$(PITCH_FACTOR),aresample=$(SAMPLE_RATE),atempo=$(TEMPO_ADJUST)" $(OUTPUT)
	rm $(TEMP_CLIP)

# Extract the relevant clip from the source
$(TEMP_CLIP): $(SOURCE_MP3)
	ffmpeg -i $(SOURCE_MP3) -ss $(START_TIME) -to $(END_TIME) -c copy $(TEMP_CLIP)

# Clean target
clean:
	rm -f $(TEMP_CLIP) $(OUTPUT)

# Check if the source file exists
check:
	@if [ ! -f $(SOURCE_MP3) ]; then \
		echo "Error: Source file $(SOURCE_MP3) not found."; \
		echo "Please place the Robin Hood intro MP3 in the current directory."; \
		exit 1; \
	fi

# Help information
help:
	@echo "Hamster Dance Maker"
	@echo ""
	@echo "Targets:"
	@echo "  make              - Create the hamster dance sound clip"
	@echo "  make clean        - Remove all generated files"
	@echo "  make check        - Check if source MP3 exists"
	@echo "  make help         - Display this help information"
	@echo ""
	@echo "Variables (can be overridden):"
	@echo "  SOURCE_MP3        - Source MP3 file (MP3 of intro to 1973 version of Disney's robin hood movie - default: $(SOURCE_MP3))"
	@echo "  OUTPUT            - Output filename (default: $(OUTPUT))"
	@echo "  PITCH_FACTOR      - Pitch multiplier (default: $(PITCH_FACTOR))"
	@echo "  TEMPO_ADJUST      - Tempo adjustment (default: $(TEMPO_ADJUST))"

.PHONY: all clean check help
