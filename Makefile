FLOW_FILES = $(shell find ./CPK -type f -name '*.flow')
BF_FILES = $(patsubst %.flow, %.BF, $(FLOW_FILES))
TARGET_DIR = "p5rpc.cheat.easierokumura"
TARGET_ZIP = p5rpc.cheat.easierokumura.zip
SCRIPT_COMPILER = wine AtlusScriptToolchain/AtlusScriptCompiler.exe
SCRIPT_COMPILER_ARGS = -Library P5R -OutFormat V3BE

$(TARGET_ZIP): $(TARGET_DIR)
	zip -r $(TARGET_ZIP) $(TARGET_DIR)

$(TARGET_DIR): $(BF_FILES)
	mkdir -p $(TARGET_DIR)/P5REssentials
	cp ModConfig.json $(TARGET_DIR)
	cp easierokumura.png $(TARGET_DIR)
	cp -r CPK $(TARGET_DIR)/P5REssentials
	find $(TARGET_DIR) -type f -name '*.flow' -delete

%.BF: %.flow
	$(SCRIPT_COMPILER) $(SCRIPT_COMPILER_ARGS) -In "$<" -Out "$@"

.PHONY: clean
clean:
	rm -rf $(TARGET_DIR) $(TARGET_ZIP) $(BF_FILES)
