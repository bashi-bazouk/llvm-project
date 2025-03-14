; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=riscv32 \
; RUN:   | FileCheck %s --check-prefixes=RV32-BOTH,RV32
; RUN: llc < %s -mtriple=riscv64 \
; RUN:   | FileCheck %s --check-prefixes=RV64-BOTH,RV64
; RUN: llc < %s -mtriple=riscv32 -mattr=+unaligned-scalar-mem \
; RUN:   | FileCheck %s --check-prefixes=RV32-BOTH,RV32-FAST
; RUN: llc < %s -mtriple=riscv64 -mattr=+unaligned-scalar-mem \
; RUN:   | FileCheck %s --check-prefixes=RV64-BOTH,RV64-FAST

; ----------------------------------------------------------------------
; Fully unaligned cases

define void @unaligned_memcpy0(ptr nocapture %dest, ptr %src) nounwind {
; RV32-BOTH-LABEL: unaligned_memcpy0:
; RV32-BOTH:       # %bb.0: # %entry
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: unaligned_memcpy0:
; RV64-BOTH:       # %bb.0: # %entry
; RV64-BOTH-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr %dest, ptr %src, i64 0, i1 false)
  ret void
}

define void @unaligned_memcpy1(ptr nocapture %dest, ptr %src) nounwind {
; RV32-BOTH-LABEL: unaligned_memcpy1:
; RV32-BOTH:       # %bb.0: # %entry
; RV32-BOTH-NEXT:    lbu a1, 0(a1)
; RV32-BOTH-NEXT:    sb a1, 0(a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: unaligned_memcpy1:
; RV64-BOTH:       # %bb.0: # %entry
; RV64-BOTH-NEXT:    lbu a1, 0(a1)
; RV64-BOTH-NEXT:    sb a1, 0(a0)
; RV64-BOTH-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr %dest, ptr %src, i64 1, i1 false)
  ret void
}

define void @unaligned_memcpy2(ptr nocapture %dest, ptr %src) nounwind {
; RV32-LABEL: unaligned_memcpy2:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    lbu a2, 1(a1)
; RV32-NEXT:    sb a2, 1(a0)
; RV32-NEXT:    lbu a1, 0(a1)
; RV32-NEXT:    sb a1, 0(a0)
; RV32-NEXT:    ret
;
; RV64-LABEL: unaligned_memcpy2:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    lbu a2, 1(a1)
; RV64-NEXT:    sb a2, 1(a0)
; RV64-NEXT:    lbu a1, 0(a1)
; RV64-NEXT:    sb a1, 0(a0)
; RV64-NEXT:    ret
;
; RV32-FAST-LABEL: unaligned_memcpy2:
; RV32-FAST:       # %bb.0: # %entry
; RV32-FAST-NEXT:    lh a1, 0(a1)
; RV32-FAST-NEXT:    sh a1, 0(a0)
; RV32-FAST-NEXT:    ret
;
; RV64-FAST-LABEL: unaligned_memcpy2:
; RV64-FAST:       # %bb.0: # %entry
; RV64-FAST-NEXT:    lh a1, 0(a1)
; RV64-FAST-NEXT:    sh a1, 0(a0)
; RV64-FAST-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr %dest, ptr %src, i64 2, i1 false)
  ret void
}

define void @unaligned_memcpy3(ptr nocapture %dest, ptr %src) nounwind {
; RV32-LABEL: unaligned_memcpy3:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    lbu a2, 2(a1)
; RV32-NEXT:    sb a2, 2(a0)
; RV32-NEXT:    lbu a2, 1(a1)
; RV32-NEXT:    sb a2, 1(a0)
; RV32-NEXT:    lbu a1, 0(a1)
; RV32-NEXT:    sb a1, 0(a0)
; RV32-NEXT:    ret
;
; RV64-LABEL: unaligned_memcpy3:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    lbu a2, 2(a1)
; RV64-NEXT:    sb a2, 2(a0)
; RV64-NEXT:    lbu a2, 1(a1)
; RV64-NEXT:    sb a2, 1(a0)
; RV64-NEXT:    lbu a1, 0(a1)
; RV64-NEXT:    sb a1, 0(a0)
; RV64-NEXT:    ret
;
; RV32-FAST-LABEL: unaligned_memcpy3:
; RV32-FAST:       # %bb.0: # %entry
; RV32-FAST-NEXT:    lbu a2, 2(a1)
; RV32-FAST-NEXT:    sb a2, 2(a0)
; RV32-FAST-NEXT:    lh a1, 0(a1)
; RV32-FAST-NEXT:    sh a1, 0(a0)
; RV32-FAST-NEXT:    ret
;
; RV64-FAST-LABEL: unaligned_memcpy3:
; RV64-FAST:       # %bb.0: # %entry
; RV64-FAST-NEXT:    lbu a2, 2(a1)
; RV64-FAST-NEXT:    sb a2, 2(a0)
; RV64-FAST-NEXT:    lh a1, 0(a1)
; RV64-FAST-NEXT:    sh a1, 0(a0)
; RV64-FAST-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr %dest, ptr %src, i64 3, i1 false)
  ret void
}

define void @unaligned_memcpy4(ptr nocapture %dest, ptr %src) nounwind {
; RV32-LABEL: unaligned_memcpy4:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    lbu a2, 3(a1)
; RV32-NEXT:    sb a2, 3(a0)
; RV32-NEXT:    lbu a2, 2(a1)
; RV32-NEXT:    sb a2, 2(a0)
; RV32-NEXT:    lbu a2, 1(a1)
; RV32-NEXT:    sb a2, 1(a0)
; RV32-NEXT:    lbu a1, 0(a1)
; RV32-NEXT:    sb a1, 0(a0)
; RV32-NEXT:    ret
;
; RV64-LABEL: unaligned_memcpy4:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    lbu a2, 3(a1)
; RV64-NEXT:    sb a2, 3(a0)
; RV64-NEXT:    lbu a2, 2(a1)
; RV64-NEXT:    sb a2, 2(a0)
; RV64-NEXT:    lbu a2, 1(a1)
; RV64-NEXT:    sb a2, 1(a0)
; RV64-NEXT:    lbu a1, 0(a1)
; RV64-NEXT:    sb a1, 0(a0)
; RV64-NEXT:    ret
;
; RV32-FAST-LABEL: unaligned_memcpy4:
; RV32-FAST:       # %bb.0: # %entry
; RV32-FAST-NEXT:    lw a1, 0(a1)
; RV32-FAST-NEXT:    sw a1, 0(a0)
; RV32-FAST-NEXT:    ret
;
; RV64-FAST-LABEL: unaligned_memcpy4:
; RV64-FAST:       # %bb.0: # %entry
; RV64-FAST-NEXT:    lw a1, 0(a1)
; RV64-FAST-NEXT:    sw a1, 0(a0)
; RV64-FAST-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr %dest, ptr %src, i64 4, i1 false)
  ret void
}

define void @unaligned_memcpy7(ptr nocapture %dest, ptr %src) nounwind {
; RV32-LABEL: unaligned_memcpy7:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    lbu a2, 6(a1)
; RV32-NEXT:    sb a2, 6(a0)
; RV32-NEXT:    lbu a2, 5(a1)
; RV32-NEXT:    sb a2, 5(a0)
; RV32-NEXT:    lbu a2, 4(a1)
; RV32-NEXT:    sb a2, 4(a0)
; RV32-NEXT:    lbu a2, 3(a1)
; RV32-NEXT:    sb a2, 3(a0)
; RV32-NEXT:    lbu a2, 2(a1)
; RV32-NEXT:    sb a2, 2(a0)
; RV32-NEXT:    lbu a2, 1(a1)
; RV32-NEXT:    sb a2, 1(a0)
; RV32-NEXT:    lbu a1, 0(a1)
; RV32-NEXT:    sb a1, 0(a0)
; RV32-NEXT:    ret
;
; RV64-LABEL: unaligned_memcpy7:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    lbu a2, 6(a1)
; RV64-NEXT:    sb a2, 6(a0)
; RV64-NEXT:    lbu a2, 5(a1)
; RV64-NEXT:    sb a2, 5(a0)
; RV64-NEXT:    lbu a2, 4(a1)
; RV64-NEXT:    sb a2, 4(a0)
; RV64-NEXT:    lbu a2, 3(a1)
; RV64-NEXT:    sb a2, 3(a0)
; RV64-NEXT:    lbu a2, 2(a1)
; RV64-NEXT:    sb a2, 2(a0)
; RV64-NEXT:    lbu a2, 1(a1)
; RV64-NEXT:    sb a2, 1(a0)
; RV64-NEXT:    lbu a1, 0(a1)
; RV64-NEXT:    sb a1, 0(a0)
; RV64-NEXT:    ret
;
; RV32-FAST-LABEL: unaligned_memcpy7:
; RV32-FAST:       # %bb.0: # %entry
; RV32-FAST-NEXT:    lw a2, 3(a1)
; RV32-FAST-NEXT:    sw a2, 3(a0)
; RV32-FAST-NEXT:    lw a1, 0(a1)
; RV32-FAST-NEXT:    sw a1, 0(a0)
; RV32-FAST-NEXT:    ret
;
; RV64-FAST-LABEL: unaligned_memcpy7:
; RV64-FAST:       # %bb.0: # %entry
; RV64-FAST-NEXT:    lw a2, 3(a1)
; RV64-FAST-NEXT:    sw a2, 3(a0)
; RV64-FAST-NEXT:    lw a1, 0(a1)
; RV64-FAST-NEXT:    sw a1, 0(a0)
; RV64-FAST-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr %dest, ptr %src, i64 7, i1 false)
  ret void
}

define void @unaligned_memcpy8(ptr nocapture %dest, ptr %src) nounwind {
; RV32-LABEL: unaligned_memcpy8:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    lbu a2, 7(a1)
; RV32-NEXT:    sb a2, 7(a0)
; RV32-NEXT:    lbu a2, 6(a1)
; RV32-NEXT:    sb a2, 6(a0)
; RV32-NEXT:    lbu a2, 5(a1)
; RV32-NEXT:    sb a2, 5(a0)
; RV32-NEXT:    lbu a2, 4(a1)
; RV32-NEXT:    sb a2, 4(a0)
; RV32-NEXT:    lbu a2, 3(a1)
; RV32-NEXT:    sb a2, 3(a0)
; RV32-NEXT:    lbu a2, 2(a1)
; RV32-NEXT:    sb a2, 2(a0)
; RV32-NEXT:    lbu a2, 1(a1)
; RV32-NEXT:    sb a2, 1(a0)
; RV32-NEXT:    lbu a1, 0(a1)
; RV32-NEXT:    sb a1, 0(a0)
; RV32-NEXT:    ret
;
; RV64-LABEL: unaligned_memcpy8:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    lbu a2, 7(a1)
; RV64-NEXT:    sb a2, 7(a0)
; RV64-NEXT:    lbu a2, 6(a1)
; RV64-NEXT:    sb a2, 6(a0)
; RV64-NEXT:    lbu a2, 5(a1)
; RV64-NEXT:    sb a2, 5(a0)
; RV64-NEXT:    lbu a2, 4(a1)
; RV64-NEXT:    sb a2, 4(a0)
; RV64-NEXT:    lbu a2, 3(a1)
; RV64-NEXT:    sb a2, 3(a0)
; RV64-NEXT:    lbu a2, 2(a1)
; RV64-NEXT:    sb a2, 2(a0)
; RV64-NEXT:    lbu a2, 1(a1)
; RV64-NEXT:    sb a2, 1(a0)
; RV64-NEXT:    lbu a1, 0(a1)
; RV64-NEXT:    sb a1, 0(a0)
; RV64-NEXT:    ret
;
; RV32-FAST-LABEL: unaligned_memcpy8:
; RV32-FAST:       # %bb.0: # %entry
; RV32-FAST-NEXT:    lw a2, 4(a1)
; RV32-FAST-NEXT:    sw a2, 4(a0)
; RV32-FAST-NEXT:    lw a1, 0(a1)
; RV32-FAST-NEXT:    sw a1, 0(a0)
; RV32-FAST-NEXT:    ret
;
; RV64-FAST-LABEL: unaligned_memcpy8:
; RV64-FAST:       # %bb.0: # %entry
; RV64-FAST-NEXT:    ld a1, 0(a1)
; RV64-FAST-NEXT:    sd a1, 0(a0)
; RV64-FAST-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr %dest, ptr %src, i64 8, i1 false)
  ret void
}

define void @unaligned_memcpy15(ptr nocapture %dest, ptr %src) nounwind {
; RV32-LABEL: unaligned_memcpy15:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    li a2, 15
; RV32-NEXT:    tail memcpy
;
; RV64-LABEL: unaligned_memcpy15:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    li a2, 15
; RV64-NEXT:    tail memcpy
;
; RV32-FAST-LABEL: unaligned_memcpy15:
; RV32-FAST:       # %bb.0: # %entry
; RV32-FAST-NEXT:    lw a2, 11(a1)
; RV32-FAST-NEXT:    sw a2, 11(a0)
; RV32-FAST-NEXT:    lw a2, 8(a1)
; RV32-FAST-NEXT:    sw a2, 8(a0)
; RV32-FAST-NEXT:    lw a2, 4(a1)
; RV32-FAST-NEXT:    sw a2, 4(a0)
; RV32-FAST-NEXT:    lw a1, 0(a1)
; RV32-FAST-NEXT:    sw a1, 0(a0)
; RV32-FAST-NEXT:    ret
;
; RV64-FAST-LABEL: unaligned_memcpy15:
; RV64-FAST:       # %bb.0: # %entry
; RV64-FAST-NEXT:    ld a2, 7(a1)
; RV64-FAST-NEXT:    sd a2, 7(a0)
; RV64-FAST-NEXT:    ld a1, 0(a1)
; RV64-FAST-NEXT:    sd a1, 0(a0)
; RV64-FAST-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr %dest, ptr %src, i64 15, i1 false)
  ret void
}

define void @unaligned_memcpy16(ptr nocapture %dest, ptr %src) nounwind {
; RV32-LABEL: unaligned_memcpy16:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    li a2, 16
; RV32-NEXT:    tail memcpy
;
; RV64-LABEL: unaligned_memcpy16:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    li a2, 16
; RV64-NEXT:    tail memcpy
;
; RV32-FAST-LABEL: unaligned_memcpy16:
; RV32-FAST:       # %bb.0: # %entry
; RV32-FAST-NEXT:    lw a2, 12(a1)
; RV32-FAST-NEXT:    sw a2, 12(a0)
; RV32-FAST-NEXT:    lw a2, 8(a1)
; RV32-FAST-NEXT:    sw a2, 8(a0)
; RV32-FAST-NEXT:    lw a2, 4(a1)
; RV32-FAST-NEXT:    sw a2, 4(a0)
; RV32-FAST-NEXT:    lw a1, 0(a1)
; RV32-FAST-NEXT:    sw a1, 0(a0)
; RV32-FAST-NEXT:    ret
;
; RV64-FAST-LABEL: unaligned_memcpy16:
; RV64-FAST:       # %bb.0: # %entry
; RV64-FAST-NEXT:    ld a2, 8(a1)
; RV64-FAST-NEXT:    sd a2, 8(a0)
; RV64-FAST-NEXT:    ld a1, 0(a1)
; RV64-FAST-NEXT:    sd a1, 0(a0)
; RV64-FAST-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr %dest, ptr %src, i64 16, i1 false)
  ret void
}

define void @unaligned_memcpy31(ptr nocapture %dest, ptr %src) nounwind {
; RV32-LABEL: unaligned_memcpy31:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    li a2, 31
; RV32-NEXT:    tail memcpy
;
; RV64-LABEL: unaligned_memcpy31:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    li a2, 31
; RV64-NEXT:    tail memcpy
;
; RV32-FAST-LABEL: unaligned_memcpy31:
; RV32-FAST:       # %bb.0: # %entry
; RV32-FAST-NEXT:    lw a2, 27(a1)
; RV32-FAST-NEXT:    sw a2, 27(a0)
; RV32-FAST-NEXT:    lw a2, 24(a1)
; RV32-FAST-NEXT:    sw a2, 24(a0)
; RV32-FAST-NEXT:    lw a2, 20(a1)
; RV32-FAST-NEXT:    sw a2, 20(a0)
; RV32-FAST-NEXT:    lw a2, 16(a1)
; RV32-FAST-NEXT:    sw a2, 16(a0)
; RV32-FAST-NEXT:    lw a2, 12(a1)
; RV32-FAST-NEXT:    sw a2, 12(a0)
; RV32-FAST-NEXT:    lw a2, 8(a1)
; RV32-FAST-NEXT:    sw a2, 8(a0)
; RV32-FAST-NEXT:    lw a2, 4(a1)
; RV32-FAST-NEXT:    sw a2, 4(a0)
; RV32-FAST-NEXT:    lw a1, 0(a1)
; RV32-FAST-NEXT:    sw a1, 0(a0)
; RV32-FAST-NEXT:    ret
;
; RV64-FAST-LABEL: unaligned_memcpy31:
; RV64-FAST:       # %bb.0: # %entry
; RV64-FAST-NEXT:    ld a2, 23(a1)
; RV64-FAST-NEXT:    sd a2, 23(a0)
; RV64-FAST-NEXT:    ld a2, 16(a1)
; RV64-FAST-NEXT:    sd a2, 16(a0)
; RV64-FAST-NEXT:    ld a2, 8(a1)
; RV64-FAST-NEXT:    sd a2, 8(a0)
; RV64-FAST-NEXT:    ld a1, 0(a1)
; RV64-FAST-NEXT:    sd a1, 0(a0)
; RV64-FAST-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr %dest, ptr %src, i64 31, i1 false)
  ret void
}

; ----------------------------------------------------------------------
; Fully aligned cases

define void @aligned_memcpy0(ptr nocapture %dest, ptr %src) nounwind {
; RV32-BOTH-LABEL: aligned_memcpy0:
; RV32-BOTH:       # %bb.0: # %entry
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: aligned_memcpy0:
; RV64-BOTH:       # %bb.0: # %entry
; RV64-BOTH-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 8 %dest, ptr align 8 %src, i64 0, i1 false)
  ret void
}

define void @aligned_memcpy1(ptr nocapture %dest, ptr %src) nounwind {
; RV32-BOTH-LABEL: aligned_memcpy1:
; RV32-BOTH:       # %bb.0: # %entry
; RV32-BOTH-NEXT:    lbu a1, 0(a1)
; RV32-BOTH-NEXT:    sb a1, 0(a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: aligned_memcpy1:
; RV64-BOTH:       # %bb.0: # %entry
; RV64-BOTH-NEXT:    lbu a1, 0(a1)
; RV64-BOTH-NEXT:    sb a1, 0(a0)
; RV64-BOTH-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 8 %dest, ptr align 8 %src, i64 1, i1 false)
  ret void
}

define void @aligned_memcpy2(ptr nocapture %dest, ptr %src) nounwind {
; RV32-BOTH-LABEL: aligned_memcpy2:
; RV32-BOTH:       # %bb.0: # %entry
; RV32-BOTH-NEXT:    lh a1, 0(a1)
; RV32-BOTH-NEXT:    sh a1, 0(a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: aligned_memcpy2:
; RV64-BOTH:       # %bb.0: # %entry
; RV64-BOTH-NEXT:    lh a1, 0(a1)
; RV64-BOTH-NEXT:    sh a1, 0(a0)
; RV64-BOTH-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 8 %dest, ptr align 8 %src, i64 2, i1 false)
  ret void
}

define void @aligned_memcpy3(ptr nocapture %dest, ptr %src) nounwind {
; RV32-BOTH-LABEL: aligned_memcpy3:
; RV32-BOTH:       # %bb.0: # %entry
; RV32-BOTH-NEXT:    lbu a2, 2(a1)
; RV32-BOTH-NEXT:    sb a2, 2(a0)
; RV32-BOTH-NEXT:    lh a1, 0(a1)
; RV32-BOTH-NEXT:    sh a1, 0(a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: aligned_memcpy3:
; RV64-BOTH:       # %bb.0: # %entry
; RV64-BOTH-NEXT:    lbu a2, 2(a1)
; RV64-BOTH-NEXT:    sb a2, 2(a0)
; RV64-BOTH-NEXT:    lh a1, 0(a1)
; RV64-BOTH-NEXT:    sh a1, 0(a0)
; RV64-BOTH-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 8 %dest, ptr align 8 %src, i64 3, i1 false)
  ret void
}

define void @aligned_memcpy4(ptr nocapture %dest, ptr %src) nounwind {
; RV32-BOTH-LABEL: aligned_memcpy4:
; RV32-BOTH:       # %bb.0: # %entry
; RV32-BOTH-NEXT:    lw a1, 0(a1)
; RV32-BOTH-NEXT:    sw a1, 0(a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: aligned_memcpy4:
; RV64-BOTH:       # %bb.0: # %entry
; RV64-BOTH-NEXT:    lw a1, 0(a1)
; RV64-BOTH-NEXT:    sw a1, 0(a0)
; RV64-BOTH-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 8 %dest, ptr align 8 %src, i64 4, i1 false)
  ret void
}

define void @aligned_memcpy7(ptr nocapture %dest, ptr %src) nounwind {
; RV32-LABEL: aligned_memcpy7:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    lbu a2, 6(a1)
; RV32-NEXT:    sb a2, 6(a0)
; RV32-NEXT:    lh a2, 4(a1)
; RV32-NEXT:    sh a2, 4(a0)
; RV32-NEXT:    lw a1, 0(a1)
; RV32-NEXT:    sw a1, 0(a0)
; RV32-NEXT:    ret
;
; RV64-LABEL: aligned_memcpy7:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    lbu a2, 6(a1)
; RV64-NEXT:    sb a2, 6(a0)
; RV64-NEXT:    lh a2, 4(a1)
; RV64-NEXT:    sh a2, 4(a0)
; RV64-NEXT:    lw a1, 0(a1)
; RV64-NEXT:    sw a1, 0(a0)
; RV64-NEXT:    ret
;
; RV32-FAST-LABEL: aligned_memcpy7:
; RV32-FAST:       # %bb.0: # %entry
; RV32-FAST-NEXT:    lw a2, 3(a1)
; RV32-FAST-NEXT:    sw a2, 3(a0)
; RV32-FAST-NEXT:    lw a1, 0(a1)
; RV32-FAST-NEXT:    sw a1, 0(a0)
; RV32-FAST-NEXT:    ret
;
; RV64-FAST-LABEL: aligned_memcpy7:
; RV64-FAST:       # %bb.0: # %entry
; RV64-FAST-NEXT:    lw a2, 3(a1)
; RV64-FAST-NEXT:    sw a2, 3(a0)
; RV64-FAST-NEXT:    lw a1, 0(a1)
; RV64-FAST-NEXT:    sw a1, 0(a0)
; RV64-FAST-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 8 %dest, ptr align 8 %src, i64 7, i1 false)
  ret void
}

define void @aligned_memcpy8(ptr nocapture %dest, ptr %src) nounwind {
; RV32-BOTH-LABEL: aligned_memcpy8:
; RV32-BOTH:       # %bb.0: # %entry
; RV32-BOTH-NEXT:    lw a2, 4(a1)
; RV32-BOTH-NEXT:    sw a2, 4(a0)
; RV32-BOTH-NEXT:    lw a1, 0(a1)
; RV32-BOTH-NEXT:    sw a1, 0(a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: aligned_memcpy8:
; RV64-BOTH:       # %bb.0: # %entry
; RV64-BOTH-NEXT:    ld a1, 0(a1)
; RV64-BOTH-NEXT:    sd a1, 0(a0)
; RV64-BOTH-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 8 %dest, ptr align 8 %src, i64 8, i1 false)
  ret void
}

define void @aligned_memcpy15(ptr nocapture %dest, ptr %src) nounwind {
; RV32-LABEL: aligned_memcpy15:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    lbu a2, 14(a1)
; RV32-NEXT:    sb a2, 14(a0)
; RV32-NEXT:    lh a2, 12(a1)
; RV32-NEXT:    sh a2, 12(a0)
; RV32-NEXT:    lw a2, 8(a1)
; RV32-NEXT:    sw a2, 8(a0)
; RV32-NEXT:    lw a2, 4(a1)
; RV32-NEXT:    sw a2, 4(a0)
; RV32-NEXT:    lw a1, 0(a1)
; RV32-NEXT:    sw a1, 0(a0)
; RV32-NEXT:    ret
;
; RV64-LABEL: aligned_memcpy15:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    lbu a2, 14(a1)
; RV64-NEXT:    sb a2, 14(a0)
; RV64-NEXT:    lh a2, 12(a1)
; RV64-NEXT:    sh a2, 12(a0)
; RV64-NEXT:    lw a2, 8(a1)
; RV64-NEXT:    sw a2, 8(a0)
; RV64-NEXT:    ld a1, 0(a1)
; RV64-NEXT:    sd a1, 0(a0)
; RV64-NEXT:    ret
;
; RV32-FAST-LABEL: aligned_memcpy15:
; RV32-FAST:       # %bb.0: # %entry
; RV32-FAST-NEXT:    lw a2, 11(a1)
; RV32-FAST-NEXT:    sw a2, 11(a0)
; RV32-FAST-NEXT:    lw a2, 8(a1)
; RV32-FAST-NEXT:    sw a2, 8(a0)
; RV32-FAST-NEXT:    lw a2, 4(a1)
; RV32-FAST-NEXT:    sw a2, 4(a0)
; RV32-FAST-NEXT:    lw a1, 0(a1)
; RV32-FAST-NEXT:    sw a1, 0(a0)
; RV32-FAST-NEXT:    ret
;
; RV64-FAST-LABEL: aligned_memcpy15:
; RV64-FAST:       # %bb.0: # %entry
; RV64-FAST-NEXT:    ld a2, 7(a1)
; RV64-FAST-NEXT:    sd a2, 7(a0)
; RV64-FAST-NEXT:    ld a1, 0(a1)
; RV64-FAST-NEXT:    sd a1, 0(a0)
; RV64-FAST-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 8 %dest, ptr align 8 %src, i64 15, i1 false)
  ret void
}

define void @aligned_memcpy16(ptr nocapture %dest, ptr %src) nounwind {
; RV32-BOTH-LABEL: aligned_memcpy16:
; RV32-BOTH:       # %bb.0: # %entry
; RV32-BOTH-NEXT:    lw a2, 12(a1)
; RV32-BOTH-NEXT:    sw a2, 12(a0)
; RV32-BOTH-NEXT:    lw a2, 8(a1)
; RV32-BOTH-NEXT:    sw a2, 8(a0)
; RV32-BOTH-NEXT:    lw a2, 4(a1)
; RV32-BOTH-NEXT:    sw a2, 4(a0)
; RV32-BOTH-NEXT:    lw a1, 0(a1)
; RV32-BOTH-NEXT:    sw a1, 0(a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: aligned_memcpy16:
; RV64-BOTH:       # %bb.0: # %entry
; RV64-BOTH-NEXT:    ld a2, 8(a1)
; RV64-BOTH-NEXT:    sd a2, 8(a0)
; RV64-BOTH-NEXT:    ld a1, 0(a1)
; RV64-BOTH-NEXT:    sd a1, 0(a0)
; RV64-BOTH-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 8 %dest, ptr align 8 %src, i64 16, i1 false)
  ret void
}

define void @aligned_memcpy31(ptr nocapture %dest, ptr %src) nounwind {
; RV32-LABEL: aligned_memcpy31:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    li a2, 31
; RV32-NEXT:    tail memcpy
;
; RV64-LABEL: aligned_memcpy31:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    lbu a2, 30(a1)
; RV64-NEXT:    sb a2, 30(a0)
; RV64-NEXT:    lh a2, 28(a1)
; RV64-NEXT:    sh a2, 28(a0)
; RV64-NEXT:    lw a2, 24(a1)
; RV64-NEXT:    sw a2, 24(a0)
; RV64-NEXT:    ld a2, 16(a1)
; RV64-NEXT:    sd a2, 16(a0)
; RV64-NEXT:    ld a2, 8(a1)
; RV64-NEXT:    sd a2, 8(a0)
; RV64-NEXT:    ld a1, 0(a1)
; RV64-NEXT:    sd a1, 0(a0)
; RV64-NEXT:    ret
;
; RV32-FAST-LABEL: aligned_memcpy31:
; RV32-FAST:       # %bb.0: # %entry
; RV32-FAST-NEXT:    lw a2, 27(a1)
; RV32-FAST-NEXT:    sw a2, 27(a0)
; RV32-FAST-NEXT:    lw a2, 24(a1)
; RV32-FAST-NEXT:    sw a2, 24(a0)
; RV32-FAST-NEXT:    lw a2, 20(a1)
; RV32-FAST-NEXT:    sw a2, 20(a0)
; RV32-FAST-NEXT:    lw a2, 16(a1)
; RV32-FAST-NEXT:    sw a2, 16(a0)
; RV32-FAST-NEXT:    lw a2, 12(a1)
; RV32-FAST-NEXT:    sw a2, 12(a0)
; RV32-FAST-NEXT:    lw a2, 8(a1)
; RV32-FAST-NEXT:    sw a2, 8(a0)
; RV32-FAST-NEXT:    lw a2, 4(a1)
; RV32-FAST-NEXT:    sw a2, 4(a0)
; RV32-FAST-NEXT:    lw a1, 0(a1)
; RV32-FAST-NEXT:    sw a1, 0(a0)
; RV32-FAST-NEXT:    ret
;
; RV64-FAST-LABEL: aligned_memcpy31:
; RV64-FAST:       # %bb.0: # %entry
; RV64-FAST-NEXT:    ld a2, 23(a1)
; RV64-FAST-NEXT:    sd a2, 23(a0)
; RV64-FAST-NEXT:    ld a2, 16(a1)
; RV64-FAST-NEXT:    sd a2, 16(a0)
; RV64-FAST-NEXT:    ld a2, 8(a1)
; RV64-FAST-NEXT:    sd a2, 8(a0)
; RV64-FAST-NEXT:    ld a1, 0(a1)
; RV64-FAST-NEXT:    sd a1, 0(a0)
; RV64-FAST-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i64(ptr align 8 %dest, ptr align 8 %src, i64 31, i1 false)
  ret void
}

; ------------------------------------------------------------------------
; A few partially aligned cases


define void @memcpy16_align4(ptr nocapture %dest, ptr nocapture %src) nounwind {
; RV32-BOTH-LABEL: memcpy16_align4:
; RV32-BOTH:       # %bb.0: # %entry
; RV32-BOTH-NEXT:    lw a2, 12(a1)
; RV32-BOTH-NEXT:    sw a2, 12(a0)
; RV32-BOTH-NEXT:    lw a2, 8(a1)
; RV32-BOTH-NEXT:    sw a2, 8(a0)
; RV32-BOTH-NEXT:    lw a2, 4(a1)
; RV32-BOTH-NEXT:    sw a2, 4(a0)
; RV32-BOTH-NEXT:    lw a1, 0(a1)
; RV32-BOTH-NEXT:    sw a1, 0(a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-LABEL: memcpy16_align4:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    lw a2, 12(a1)
; RV64-NEXT:    sw a2, 12(a0)
; RV64-NEXT:    lw a2, 8(a1)
; RV64-NEXT:    sw a2, 8(a0)
; RV64-NEXT:    lw a2, 4(a1)
; RV64-NEXT:    sw a2, 4(a0)
; RV64-NEXT:    lw a1, 0(a1)
; RV64-NEXT:    sw a1, 0(a0)
; RV64-NEXT:    ret
;
; RV64-FAST-LABEL: memcpy16_align4:
; RV64-FAST:       # %bb.0: # %entry
; RV64-FAST-NEXT:    ld a2, 8(a1)
; RV64-FAST-NEXT:    sd a2, 8(a0)
; RV64-FAST-NEXT:    ld a1, 0(a1)
; RV64-FAST-NEXT:    sd a1, 0(a0)
; RV64-FAST-NEXT:    ret
entry:
  tail call void @llvm.memcpy.p0.p0.i32(ptr align 4 %dest, ptr align 4 %src, i32 16, i1 false)
  ret void
}

define i32 @memcpy11_align8(ptr nocapture %dest, ptr %src) {
; RV32-LABEL: memcpy11_align8:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    lbu a2, 10(a1)
; RV32-NEXT:    sb a2, 10(a0)
; RV32-NEXT:    lh a2, 8(a1)
; RV32-NEXT:    sh a2, 8(a0)
; RV32-NEXT:    lw a2, 4(a1)
; RV32-NEXT:    sw a2, 4(a0)
; RV32-NEXT:    lw a1, 0(a1)
; RV32-NEXT:    sw a1, 0(a0)
; RV32-NEXT:    li a0, 0
; RV32-NEXT:    ret
;
; RV64-LABEL: memcpy11_align8:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    lbu a2, 10(a1)
; RV64-NEXT:    sb a2, 10(a0)
; RV64-NEXT:    lh a2, 8(a1)
; RV64-NEXT:    sh a2, 8(a0)
; RV64-NEXT:    ld a1, 0(a1)
; RV64-NEXT:    sd a1, 0(a0)
; RV64-NEXT:    li a0, 0
; RV64-NEXT:    ret
;
; RV32-FAST-LABEL: memcpy11_align8:
; RV32-FAST:       # %bb.0: # %entry
; RV32-FAST-NEXT:    lw a2, 7(a1)
; RV32-FAST-NEXT:    sw a2, 7(a0)
; RV32-FAST-NEXT:    lw a2, 4(a1)
; RV32-FAST-NEXT:    sw a2, 4(a0)
; RV32-FAST-NEXT:    lw a1, 0(a1)
; RV32-FAST-NEXT:    sw a1, 0(a0)
; RV32-FAST-NEXT:    li a0, 0
; RV32-FAST-NEXT:    ret
;
; RV64-FAST-LABEL: memcpy11_align8:
; RV64-FAST:       # %bb.0: # %entry
; RV64-FAST-NEXT:    lw a2, 7(a1)
; RV64-FAST-NEXT:    sw a2, 7(a0)
; RV64-FAST-NEXT:    ld a1, 0(a1)
; RV64-FAST-NEXT:    sd a1, 0(a0)
; RV64-FAST-NEXT:    li a0, 0
; RV64-FAST-NEXT:    ret
entry:
  call void @llvm.memcpy.p0.p0.i32(ptr align 8 %dest, ptr align 8 %src, i32 11, i1 false)
  ret i32 0
}

declare void @llvm.memcpy.p0.p0.i32(ptr nocapture, ptr nocapture, i32, i1) nounwind
declare void @llvm.memcpy.p0.p0.i64(ptr nocapture, ptr nocapture, i64, i1) nounwind
