                    .data
type__num:          .asciz "%d"
num_1 :             .word   1500
num_2 :             .word   1000
num_3 :             .word   4000000
num_4 :             .word   0xffff


                    .text
                    .global drawJuliaSet

drawJuliaSet:
                    stmfd   sp!,{fp,lr}
                    mov     r5, #0
                    addeq   r11, r0, r5
                    add     fp, sp, #4
                    sub     sp, sp, #48
                    str     r0, [fp, #-40]          @ store cX in fp-40
                    str     r1, [fp, #-44]          @ store cY in fp-44
                    str     r2, [fp, #-48]          @ store width in fp-48
                    str     r3, [fp, #-52]          @ store height in fp-52
                    mov     r2, #255                @ r2 = 255
                    str     r2, [fp, #-28]          @ store maxIter in fp-28
                    mov     r2, #0                  @ r2 = 0
                    str     r2, [fp, #-20]          @ store x in fp-20, x = 0
                    b       for_width
for_height:
                    mov     r2, #0                  @ r2 = 0
                    str     r2, [fp, #-24]          @ store y in fp-24, y = 0
                    b       for_height_con          @ branch to for_height_con

first:
                    ldr     r2, [fp, #-48]          @ r2 = width
                    mov     r3, #1
                    mov     r2, r2, asr r3          @ r2 = width>>1
                    ldr     r3, [fp, #-20]          @ r3 = x
                    sub     r3, r3, r2              @ r3 = x-(width>>1)
                    ldr     r2, =num_1              @ r2 = 1500
                    ldr     r2, [r2]
                    mul     r3, r3, r2              @ r3 = 1500(x-(width>>1))
                    ldr     r2, [fp, #-48]          @ r2 = width
                    mov     r2, r2, asr #1          @ r2 = width>>1
                    mov     r0, r3                  @ r0 = r3
                    mov     r1, r2                  @ r1 = r2
                    bl      __aeabi_idiv            @ r0 = 1500(x-(width>>1))/width>>1
                    str     r0, [fp, #-8]           @ store the result in zx

                    ldr     r2, [fp, #-52]          @ r2 = height
                    ldr     r3, [fp, #-24]          @ r3 = y
                    mov     r2, r2, asr #1          @ r2 = height>>1
                    sub     r3, r3, r2              @ r3 = y-(height>>1)
                    ldr     r2, =num_2              @ r2 = 1000
                    ldr     r2, [r2]
                    mul     r3, r3, r2              @ r3 = 1000(y-(height>>1))
                    ldr     r2, [fp, #-52]          @ r2 = height
                    mov     r2, r2, asr #1          @ r2 = height>>1
                    mov     r0, r3                  @ r0 = r3
                    mov     r1, r2                  @ r1 = r2
                    bl      __aeabi_idiv            @ r0 = 1000(y-(height>>1))/height>>1
                    str     r0, [fp, #-12]          @ store the result in zy

                    ldr     r2, [fp, #-28]          @ r2 = maxIter
                    str     r2, [fp, #-16]          @ store maxIter in i
                    b       while_con               @ branch to while_con
second:

                    ldr     r2, [fp, #-8]           @ r2 = zx
                    mov     r3, r2                  @ r3 = zx
                    mul     r2, r2, r3              @ r2 = zx*zx
                    ldr     r3, [fp, #-12]          @ r3 = zy
                    mov     r4, r3                  @ r4 = zy
                    mul     r3, r3, r4              @ r3 = zy*zy
                    sub     r0, r2, r3              @ r0 = zx*zx-zy*zy
                    ldr     r1, =num_2              @ r1 = 1000
                    ldr     r1, [r1]
                    bl      __aeabi_idiv            @ r0 = (zx*zx-zy*zy)/1000
                    ldr     r2, [fp, #-40]          @ r2 = cX
                    add     r0, r0, r2              @ r0 = (zx*zx-zy*zy)/1000 + cX
                    str     r0, [fp, #-32]          @ store the result in temp

                    ldr     r2, [fp, #-8]           @ r2 = zx
                    mov     r2, r2, asl #1          @ r2 = zx*2
                    ldr     r3, [fp, #-12]          @ r3 = zy
                    mul     r0, r2, r3              @ r2 = 2*zx*zy
                    ldr     r1, =num_2              @ r1 = 1000
                    ldr     r1, [r1]
                    bl      __aeabi_idiv            @ r0 = (2*zx*zy)/1000
                    ldr     r2, [fp, #-44]          @ r2 = cY
                    add     r2, r0, r2              @ r2 = (2*zx*zy)/1000 + cY
                    str     r2, [fp, #-12]          @ store the result in zy
                    ldr     r2, [fp, #-32]          @ r2 = temp
                    str     r2, [fp, #-8]           @ zx = temp

                    ldr     r2, [fp, #-16]          @ r2 = i
                    sub     r2, r2, #1              @ i--
                    str     r2, [fp, #-16]          @ store the result in i


while_con:

                    ldr     r2, [fp, #-8]           @ r2 = zx
                    mov     r3, r2                  @ r3 = zx
                    mul     r2, r2, r3              @ r2 = zx*zx
                    ldr     r3, [fp, #-12]          @ r3 = zy
                    mov     r4, r3                  @ r4 = zy
                    mul     r3, r3, r4              @ r3 = zy*zy
                    add     r3, r3, r2              @ r3 = zx*zx+zy*zy
                    ldr     r2, =num_3              @ r2 = 4000000
                    ldr     r2, [r2]
                    cmp     r3, r2                  @ cmp zx*zx+zy*zy and 4000000
                    bge     third                   @ if zx*zx+zy*zy >= 4000000, branch to third
                    ldr     r4, [fp, #-16]          @ r4 = i
                    cmplt   r4, #0                  @ if zx*zx+zy*zy<4000000, cmp i and 0
                    bgt     second                  @ if zx*zx+zy*zy < 4000000, branch to second

third:

                    ldr     r2, [fp, #-16]          @ r2 = i
                    mov     r3, r2                  @ r3 = i
                    and     r2, r2, #0xff           @ r2 = i&0xff
                    mov     r2, r2, lsl #8          @ r2 = (i&0xff)<<8
                    and     r3, r3, #0xff           @ r3 = i&0xff
                    orr     r2, r2, r3              @ r2 = (i&0xff)<<8 | i&0xff
                    strh    r2, [fp, #-34]          @ store the result in color(hword)
                    ldrh    r2, [fp, #-34]          @ r2 = color(hword)
                    mvn     r3, r2                  @ r3 = ~color(hword)
                    strh    r3, [fp, #-34]          @ store the result in color(hword)

                    ldr     r2, [fp, #-24]          @ r2 = y
                    mov     r3, #10                 @ r3 = 10
                    mul     r2, r2, r3              @ r2 = 10y
                    mov     r2, r2, asl #7          @ r2 = 10y*128
                    ldr     r3, [fp, #4]            @ r3 = frame address
                    add     r3, r3, r2              @ r3 = frame+1280y
                    ldr     r2, [fp, #-20]          @ r2 = x
                    mov     r2, r2, asl #1          @ r2 = 2x
                    add     r3, r3, r2              @ r3 = frame+1280y+2x
                    ldrh    r2, [fp, #-34]          @ r2 = color
                    strh    r2, [r3]                @ store the color(hword) into frame array

                    ldr     r2, [fp, #-24]          @ r2 = y
                    add     r2, r2, #1              @ y++
                    str     r2, [fp, #-24]          @ store the value into y address

for_height_con:
                    ldr     r2, [fp, #-24]          @ r2 = y
                    ldr     r3, [fp, #-52]          @ r3 = height
                    cmp     r2, r3                  @ cmp y and height
                    ldrge   r2, [fp, #-20]          @ r2 = x
                    addge   r2, r2, #1              @ x ++
                    strge   r2, [fp, #-20]
                    blt     first                   @ if y < height, branch to first
for_width:
                    ldr     r2, [fp, #-20]          @ r2 = x
                    ldr     r3, [fp, #-48]          @ r3 = width
                    cmp     r2, r3                  @ cmp x and width
                    blt     for_height              @ if x < width, branch to for_height
                    subge   sp, fp, #4              @ sp = sp -4 (lr)
                    sbcs    r11, r0, r1
                    ldmfd   sp!, {fp, lr}
                    mov     pc, lr

