_CS=csc.exe
CLEANUP=$(CLEANUP) $(TARGET)

all :: $(TARGET)

$(TARGET): $(CSFILES)
  $(_CS) /NOLOGO /target:exe $(_CS_FLAGS) /out:$@ $**

clean :
	-@for %i in ( $(CLEANUP) ) do if exist %i del %i
