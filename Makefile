NAME = bs

#general and mostly system-wide includes for Nesdoug tutorial
#path definitions
CC65 = cc65
CA65 = ca65
LD65 = ld65

#select correct delete command for Win or Unix
ifdef ComSpec
    RM=del
else
    RM=rm -f
endif 

#$(NAME) should be defined in your lesson Makefile
ifndef NAME
$(error You shouldn't run this makefile directly. Include it to your lesson makefile and define NAME equal to lesson name, e.g. lesson1)
endif

$(NAME).nes: $(NAME).o
	$(LD65) $(NAME).o -Ln labels.txt -C nes.cfg -o $(NAME).nes 
$(NAME).o: $(NAME).asm 
	$(CA65) $(NAME).asm --debug-info

reset.o: reset.asm
	$(CA65) reset.asm

nmi_handler.o: nmi_handler.asm
	$(CA65) nmi_handler.asm
clean:
	$(RM) *.nes
	$(RM) *.o
