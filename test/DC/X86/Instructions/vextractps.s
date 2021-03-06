# RUN: llvm-mc -triple x86_64--darwin -filetype=obj -o - %s | llvm-dec - -dc-translate-unknown-to-undef -enable-dc-reg-mock-intrin | FileCheck %s

## VEXTRACTPSmr
# CHECK-LABEL: call void @llvm.dc.startinst
# CHECK-NEXT: [[RIP_0:%.+]] = call i64 @llvm.dc.getreg.i64(metadata !"RIP")
# CHECK-NEXT: [[V0:%.+]] = add i64 [[RIP_0]], 8
# CHECK-NEXT: call void @llvm.dc.setreg{{.*}} !"RIP")
# CHECK-NEXT: [[XMM13_0:%.+]] = call <4 x float> @llvm.dc.getreg.v4f32(metadata !"XMM13")
# CHECK-NEXT: [[V1:%.+]] = bitcast <4 x float> [[XMM13_0]] to i128
# CHECK-NEXT: [[V2:%.+]] = bitcast i128 [[V1]] to <4 x float>
# CHECK-NEXT: [[V3:%.+]] = bitcast <4 x float> [[V2]] to <4 x i32>
# CHECK-NEXT: [[V4:%.+]] = extractelement <4 x i32> [[V3]], i64 2
# CHECK-NEXT: [[R11_0:%.+]] = call i64 @llvm.dc.getreg.i64(metadata !"R11")
# CHECK-NEXT: [[RBX_0:%.+]] = call i64 @llvm.dc.getreg.i64(metadata !"RBX")
# CHECK-NEXT: [[V5:%.+]] = mul i64 [[RBX_0]], 2
# CHECK-NEXT: [[V6:%.+]] = add i64 [[V5]], 2
# CHECK-NEXT: [[V7:%.+]] = add i64 [[R11_0]], [[V6]]
# CHECK-NEXT: [[V8:%.+]] = inttoptr i64 [[V7]] to float*
# CHECK-NEXT: [[V9:%.+]] = bitcast float* [[V8]] to i32*
# CHECK-NEXT: store i32 [[V4]], i32* [[V9]], align 1
vextractps	$2, %xmm13, 2(%r11,%rbx,2)

## VEXTRACTPSrr
# CHECK-LABEL: call void @llvm.dc.startinst
# CHECK-NEXT: [[RIP_0:%.+]] = call i64 @llvm.dc.getreg.i64(metadata !"RIP")
# CHECK-NEXT: [[V0:%.+]] = add i64 [[RIP_0]], 6
# CHECK-NEXT: call void @llvm.dc.setreg{{.*}} !"RIP")
# CHECK-NEXT: [[XMM9_0:%.+]] = call <4 x float> @llvm.dc.getreg.v4f32(metadata !"XMM9")
# CHECK-NEXT: [[V1:%.+]] = bitcast <4 x float> [[XMM9_0]] to i128
# CHECK-NEXT: [[V2:%.+]] = bitcast i128 [[V1]] to <4 x float>
# CHECK-NEXT: [[V3:%.+]] = bitcast <4 x float> [[V2]] to <4 x i32>
# CHECK-NEXT: [[V4:%.+]] = extractelement <4 x i32> [[V3]], i64 2
# CHECK-NEXT: call void @llvm.dc.setreg.i32(i32 [[V4]], metadata !"R8D")
vextractps	$2, %xmm9, %r8d

retq
