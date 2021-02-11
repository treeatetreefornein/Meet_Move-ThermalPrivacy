SHELL := /bin/sh

DOCUMENT=monitorResearch
REFERENCES=references

GETDIGEST=$(eval DIGEST=$(shell script/getDigest.sh))

.PHONY: doc clean upload digest

all: doc

doc: $(DOCUMENT).ms
	@refer -e -p $(REFERENCES) "$(DOCUMENT).ms" | groff -Kutf8 -Tutf8 -Tps -t -e -ms > "$(DOCUMENT).ps"
	@ps2pdf "$(DOCUMENT).ps"
clean: $(DOCUMENT).pdf
	@rm -v "$(DOCUMENT).pdf" "$(DOCUMENT).ps"
upload: $(DOCUMENT).pdf
	$(GETDIGEST) 
	@script/uploadDoc.sh $(DIGEST)
	@script/finishDoc.sh "../$(DOCUMENT).pdf" $(DIGEST)
