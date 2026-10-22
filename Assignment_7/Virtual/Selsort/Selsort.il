// Source:
//   public static void SelectionSort(int[] arr) {
//     for (int i = 0; i < arr.Length; i++) {
//       int least = i;
//       for (int j = i+1; j < arr.Length; j++)
//         if (arr[j] < arr[least])
//           least = j;
//       int tmp = arr[i]; arr[i] = arr[least]; arr[least] = tmp;
//     }
//   }
//
// Local variables:
//   arg 0   = arr     (the parameter; read with ldarg.0)
//   local 0 = i
//   local 1 = least
//   local 2 = tmp
//   local 3 = j
//
// The .NET machine is a stack machine: instructions take their operands from
// the top of the evaluation stack and push their result back.
// In the stack comments below, the top of the stack is on the right.
//
// Notice that both for-loops are compiled with the test at the BOTTOM:
// the code first jumps (br.s) to the condition, and the condition jumps
// back to the loop body (blt.s) while it is true. That way each iteration
// executes only one conditional jump.

	.method public hidebysig static
		void SelectionSort (
			int32[] arr
		) cil managed
	{
		.maxstack 4             // at most 4 values on the evaluation stack at once
		.locals init (          // declare the 4 local variables, initialized to 0
			[0] int32,          // i
			[1] int32,          // least
			[2] int32,          // tmp
			[3] int32           // j
		)

		// ---- for (int i = 0; ...) : initialization ----
		IL_0000: ldc.i4.0          // push the int constant 0           stack: 0
		IL_0001: stloc.0           // pop into local 0:  i = 0          stack: (empty)
		IL_0002: br.s IL_0032      // jump to the outer loop condition at IL_0032

		// ---- outer loop body ----
			IL_0004: ldloc.0       // push i                            stack: i
			IL_0005: stloc.1       // least = i                         stack: (empty)

			// ---- for (int j = i+1; ...) : initialization ----
			IL_0006: ldloc.0       // push i                            stack: i
			IL_0007: ldc.i4.1      // push 1                            stack: i, 1
			IL_0008: add           // pop two, push their sum           stack: i+1
			IL_0009: stloc.3       // j = i+1                           stack: (empty)
			IL_000a: br.s IL_001a  // jump to the inner loop condition at IL_001a

			// ---- inner loop body: if (arr[j] < arr[least]) least = j; ----
				IL_000c: ldarg.0       // push arr (a reference to the array)   stack: arr
				IL_000d: ldloc.3       // push j                                stack: arr, j
				IL_000e: ldelem.i4     // pop array and index, push arr[j]      stack: arr[j]
				IL_000f: ldarg.0       // push arr                              stack: arr[j], arr
				IL_0010: ldloc.1       // push least                            stack: arr[j], arr, least
				IL_0011: ldelem.i4     // push arr[least]                       stack: arr[j], arr[least]
				IL_0012: bge.s IL_0016 // pop both; if arr[j] >= arr[least], skip the
				                       // assignment (the if-condition negated)  stack: (empty)

				IL_0014: ldloc.3       // push j
				IL_0015: stloc.1       // least = j

				// ---- j++ ----
				IL_0016: ldloc.3       // push j                                stack: j
				IL_0017: ldc.i4.1      // push 1                                stack: j, 1
				IL_0018: add           //                                       stack: j+1
				IL_0019: stloc.3       // j = j+1                               stack: (empty)

				// ---- inner loop condition: j < arr.Length ----
				IL_001a: ldloc.3       // push j                                stack: j
				IL_001b: ldarg.0       // push arr                              stack: j, arr
				IL_001c: ldlen         // pop arr, push its length (as native unsigned int)
				                       //                                       stack: j, arr.Length
				IL_001d: conv.i4       // convert the length to a 32-bit int   stack: j, arr.Length
				IL_001e: blt.s IL_000c // pop both; if j < arr.Length, jump back to the
				                       // inner loop body                       stack: (empty)
			// end of inner loop

			// ---- int tmp = arr[i]; ----
			IL_0020: ldarg.0       // push arr                              stack: arr
			IL_0021: ldloc.0       // push i                                stack: arr, i
			IL_0022: ldelem.i4     // push arr[i]                           stack: arr[i]
			IL_0023: stloc.2       // tmp = arr[i]                          stack: (empty)

			// ---- arr[i] = arr[least]; ----
			IL_0024: ldarg.0       // push arr (the array to store into)    stack: arr
			IL_0025: ldloc.0       // push i (the index to store at)        stack: arr, i
			IL_0026: ldarg.0       // push arr                              stack: arr, i, arr
			IL_0027: ldloc.1       // push least                            stack: arr, i, arr, least
			IL_0028: ldelem.i4     // push arr[least]                       stack: arr, i, arr[least]
			IL_0029: stelem.i4     // pop value, index and array:
			                       // arr[i] = arr[least]                   stack: (empty)
			                       // (this is the point where .maxstack 4 is reached)

			// ---- arr[least] = tmp; ----
			IL_002a: ldarg.0       // push arr                              stack: arr
			IL_002b: ldloc.1       // push least                            stack: arr, least
			IL_002c: ldloc.2       // push tmp                              stack: arr, least, tmp
			IL_002d: stelem.i4     // arr[least] = tmp                      stack: (empty)

			// ---- i++ ----
			IL_002e: ldloc.0       // push i                                stack: i
			IL_002f: ldc.i4.1      // push 1                                stack: i, 1
			IL_0030: add           //                                       stack: i+1
			IL_0031: stloc.0       // i = i+1                               stack: (empty)

			// ---- outer loop condition: i < arr.Length ----
			IL_0032: ldloc.0       // push i                                stack: i
			IL_0033: ldarg.0       // push arr                              stack: i, arr
			IL_0034: ldlen         // push arr.Length                       stack: i, arr.Length
			IL_0035: conv.i4       // convert to int32                      stack: i, arr.Length
			IL_0036: blt.s IL_0004 // if i < arr.Length, jump back to the
			                       // outer loop body                       stack: (empty)
		// end of outer loop

		IL_0038: ret               // return from the method (void, so nothing is returned)
	} // end of method Selsort::SelectionSort

// Notes on the instruction names (Ecma-335, Partition III):
//   ldc.i4.N   load constant: push the int32 constant N (short form for 0..8)
//   ldloc.N    load local variable N onto the stack
//   stloc.N    pop the top of the stack into local variable N
//   ldarg.0    load argument 0 (here the parameter arr)
//   ldelem.i4  pop an array reference and an index, push the int32 element
//   stelem.i4  pop an array reference, an index and an int32 value, store the value
//   ldlen      pop an array reference, push the number of elements (native unsigned int)
//   conv.i4    convert the top of the stack to int32
//   add        pop two values, push their sum
//   br.s L     unconditional branch to L (".s" = short form, 1-byte offset)
//   blt.s L    pop two values, branch to L if the first < the second
//   bge.s L    pop two values, branch to L if the first >= the second
//   ret        return from the method
