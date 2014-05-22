; RUN: llc -march=r600 -mcpu=SI -verify-machineinstrs < %s | FileCheck -check-prefix=SI -check-prefix=FUNC %s
; RUN: llc -march=r600 -mcpu=cayman -verify-machineinstrs < %s | FileCheck -check-prefix=CM -check-prefix=FUNC %s

declare i32 @llvm.AMDGPU.imad24(i32, i32, i32) nounwind readnone

; FUNC-LABEL: @test_imad24
; SI: V_MAD_I32_I24
; CM: MULADD_INT24
define void @test_imad24(i32 addrspace(1)* %out, i32 %src0, i32 %src1, i32 %src2) nounwind {
  %mad = call i32 @llvm.AMDGPU.imad24(i32 %src0, i32 %src1, i32 %src2) nounwind readnone
  store i32 %mad, i32 addrspace(1)* %out, align 4
  ret void
}
