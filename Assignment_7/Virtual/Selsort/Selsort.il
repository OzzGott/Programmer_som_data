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


// Both for-loops are compiled with the test at the bottom: the code first jumps
// to the condition, and the condition jumps back to the body while it is true.

	.method public hidebysig static
		void SelectionSort (
			int32[] arr
		) cil managed
	{
		.maxstack 4             // stack is max 4 vals
		.locals init (          // vals are declared and initialized to 0
			[0] int32,          // i
			[1] int32,          // least
			[2] int32,          // tmp
			[3] int32           // j
		)

		// i = 0, then jump to the outer loop test
		IL_0000: ldc.i4.0
		IL_0001: stloc.0
		IL_0002: br.s IL_0032

			// least = i
			IL_0004: ldloc.0
			IL_0005: stloc.1

			// j = i + 1, then jump to the inner loop test
			IL_0006: ldloc.0
			IL_0007: ldc.i4.1
			IL_0008: add
			IL_0009: stloc.3
			IL_000a: br.s IL_001a

				// if (arr[j] < arr[least]): load both elements and skip
				// the assignment if arr[j] >= arr[least]
				IL_000c: ldarg.0
				IL_000d: ldloc.3
				IL_000e: ldelem.i4
				IL_000f: ldarg.0
				IL_0010: ldloc.1
				IL_0011: ldelem.i4
				IL_0012: bge.s IL_0016

				// least = j
				IL_0014: ldloc.3
				IL_0015: stloc.1

				// j++
				IL_0016: ldloc.3
				IL_0017: ldc.i4.1
				IL_0018: add
				IL_0019: stloc.3

				// inner loop test: jump back to the body while j < arr.Length
				// (ldlen gives a native unsigned int, so conv.i4 converts it to int32)
				IL_001a: ldloc.3
				IL_001b: ldarg.0
				IL_001c: ldlen
				IL_001d: conv.i4
				IL_001e: blt.s IL_000c

			// tmp = arr[i]
			IL_0020: ldarg.0
			IL_0021: ldloc.0
			IL_0022: ldelem.i4
			IL_0023: stloc.2

			// arr[i] = arr[least]: push array and index first, then the value
			IL_0024: ldarg.0
			IL_0025: ldloc.0
			IL_0026: ldarg.0
			IL_0027: ldloc.1
			IL_0028: ldelem.i4
			IL_0029: stelem.i4

			// arr[least] = tmp
			IL_002a: ldarg.0
			IL_002b: ldloc.1
			IL_002c: ldloc.2
			IL_002d: stelem.i4

			// i++
			IL_002e: ldloc.0
			IL_002f: ldc.i4.1
			IL_0030: add
			IL_0031: stloc.0

		// outer loop test: jump back to the body while i < arr.Length
		IL_0032: ldloc.0
		IL_0033: ldarg.0
		IL_0034: ldlen
		IL_0035: conv.i4
		IL_0036: blt.s IL_0004

		IL_0038: ret
	} // end of method Selsort::SelectionSort
