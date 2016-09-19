#include "pin.H"
#include <iostream>
#include <fstream>
#include "instlib.H"
#include <algorithm>
#include <string>
using namespace INSTLIB;
/* ================================================================== */
// Global variables 
/* ================================================================== */

static UINT64 insCount = 0;        //number of dynamically executed instructions
static UINT64 dataTransferInsCount = 0;        
static UINT64 arithmeticInsCount = 0;
static UINT64 branchCount = 0;
string functionName = "";
FILTER filter;
std::ofstream TraceFile;

/* ===================================================================== */
// Command line switches
/* ===================================================================== */
KNOB<string> KnobOutputFile(KNOB_MODE_WRITEONCE,  "pintool",
    "o", "", "specify file name for MyPinTool output");

/*!
 *  Print out help message.
 */
INT32 Usage()
{
    cerr << "This tool prints out the number of dynamically executed " << endl <<
            "instructions, basic blocks and threads in the application." << endl << endl;

    cerr << KNOB_BASE::StringKnobSummary() << endl;

    return -1;
}

VOID ArithIns()
{
        arithmeticInsCount++;
}

VOID MovIns()
{
    dataTransferInsCount++;
}

VOID IncrementIns(UINT32 amount)
{
    insCount += amount;
}

VOID BranchIns()
{
    branchCount++;
}

VOID Trace(TRACE trace, VOID *v)
{
    if (filter.SelectTrace(trace))
    {    
        for (BBL bbl = TRACE_BblHead(trace); BBL_Valid(bbl); bbl = BBL_Next(bbl))
        {
            for (INS ins = BBL_InsHead(bbl); INS_Valid(ins); ins = INS_Next(ins))
            {
                if (INS_IsBranchOrCall(ins)) {
                    INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)BranchIns, IARG_END);
                }
                else if (INS_IsRet(ins)) {
                    INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)BranchIns, IARG_END);
                }
                else if (INS_IsMov(ins)) {
                    INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)MovIns, IARG_END);
                }
                else if (INS_IsMemoryWrite(ins) or INS_IsMemoryRead(ins))
                {
                    INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)MovIns, IARG_END);
                }
                else {
                    INS_InsertCall(ins, IPOINT_BEFORE, (AFUNPTR)ArithIns, IARG_END);
                }
            }
            BBL_InsertCall(bbl, IPOINT_BEFORE, (AFUNPTR)IncrementIns, IARG_UINT32, BBL_NumIns(bbl), IARG_END);
            BBL_InsertCall(bbl, IPOINT_BEFORE, (AFUNPTR)IncrementBBL, IARG_END); 
        }
    }
}

/* bytes range tainted */
/*!
 * Print out analysis results.
 * This function is called when the application exits.
 * @param[in]   code            exit code of the application
 * @param[in]   v               value specified by the tool in the 
 *                              PIN_AddFiniFunction function call
 */
VOID Fini(INT32 code, VOID *v)
{
    TraceFile << "branchCount: " << branchCount << endl;
    TraceFile << "insCount: " << insCount << endl;
    TraceFile << "arithmeticInsCount: " << arithmeticInsCount  <<  endl;
    TraceFile << "dataTransferInsCount: " << dataTransferInsCount  << endl;
    if (TraceFile.is_open()) { TraceFile.close(); }
}

/*!
 * The main procedure of the tool.
 * This function is called when the application image is loaded but not yet started.
 * @param[in]   argc            total number of elements in the argv array
 * @param[in]   argv            array of command line arguments, 
 *                              including pin -t <toolname> -- ...
 */
int main(int argc, char *argv[])
{
    // Initialize PIN library. Print help message if -h(elp) is specified
    // in the command line or the command line is invalid 
    if( PIN_Init(argc,argv) )
    {
        return Usage();
    } 
    TraceFile.open(KnobOutputFile.Value().c_str());
    TRACE_AddInstrumentFunction(Trace, 0);
    PIN_AddFiniFunction(Fini, 0);
    filter.Activate();
    // Start the program, never returns
    PIN_StartProgram();
    
    return 0;
}

/* ===================================================================== */
/* eof */
/* ===================================================================== */
