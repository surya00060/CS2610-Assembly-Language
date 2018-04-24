SECTIONS {
.text 0xa000: { *(.text) }
.data : { *(.data) } 
.bss :  { *(.bss)  *(COMMON) } 
kama 0xc000: { * (kama) } 
}
