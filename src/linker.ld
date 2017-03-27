/******************************************************************************
    * This linker file was developed by Hussam Al-Hertani. Please use freely as
    * long as you leave this header in place. The author is not responsible for any
    * damage or liability that this file might cause.
******************************************************************************/

/* Entry Point */
ENTRY(Reset_Handler)

MEMORY {
	FLASH (rx)      : ORIGIN = 0x00000000, LENGTH = 0x10000 /*64K*/
	RAM (xrw)       : ORIGIN = 0x20000000, LENGTH = 0x02000 /*8K*/
}

/* Define stack size and heap size */
stack_size = 1024;
heap_size = 256;

/* Define beginning and ending of stack */
_stack_start = ORIGIN(RAM)+LENGTH(RAM);
_stack_end = _stack_start - stack_size;

SECTIONS {
	/* ISR vectors goes to beginning of FLASH */
	.isr_vector : {
		. = ALIGN(4);
		KEEP(*(.isr_vector)) /* ISR Vectors */
	 	. = ALIGN(4);
	} >FLASH

	/* The program code and constant data goes into FLASH */
	.text : {
		. = ALIGN(4);
		*(.text)           /* .text sections (code) */
		*(.text*)          /* .text* sections (code) */
		*(.rodata)         /* .rodata sections (constants, strings, etc.) */
		*(.rodata*)        /* .rodata* sections (constants, strings, etc.) */
		*(.glue_7)         /* glue arm to thumb code */
		*(.glue_7t)        /* glue thumb to arm code */
		. = ALIGN(4);
		_etext = .;        /* define a global symbols at end of code */
	} >FLASH

  .ARM.extab   : { *(.ARM.extab* .gnu.linkonce.armextab.*) } >FLASH
	.ARM : {
		__exidx_start = .;
		 *(.ARM.exidx*)
		 __exidx_end = .;
	} >FLASH

	/* used by the startup to initialize data */
	_sidata = .;

	/* Initialized data sections goes into RAM, load LMA copy after code */
	.data : AT ( _sidata ) {
		. = ALIGN(4);
		_sdata = .;        /* create a global symbol at data start */
		*(.data)           /* .data sections */
		*(.data*)          /* .data* sections */

		. = ALIGN(4);
		_edata = .;        /* define a global symbol at data end */
	} >RAM

	/* Uninitialized data section */
	. = ALIGN(4);
	.bss : {
		/*  Used by the startup in order to initialize the .bss secion */
		_sbss = .;         /* define a global symbol at bss start */
		__bss_start__ = _sbss;
		*(.bss)
		*(.bss*)
		*(COMMON)

		. = ALIGN(4);
		_ebss = .;         /* define a global symbol at bss end */
		__bss_end__ = _ebss;
	} >RAM

	. = ALIGN(4);
	.heap : {
		_heap_start = .;
		. = . + heap_size;
		_heap_end = .;
	} > RAM

	/* Remove information from the standard libraries */
	/DISCARD/ : {
		libc.a ( * )
		libm.a ( * )
		libgcc.a ( * )
	}

	.ARM.attributes 0 : { *(.ARM.attributes) }
}
