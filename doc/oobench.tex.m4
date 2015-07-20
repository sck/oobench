m4_divert(-1) 
m4_changequote({[,]}) 
m4_changecom({[]},{[]})
m4_divert

m4_ifdef({[oob_pdf]}, 
{[
    \documentclass[11pt,pdftex]{scrartcl}
]}, {[
    m4_ifdef({[oob_html]},{[
        \documentclass[11pt]{article}
    ]},{[
        \documentclass[11pt]{scrartcl}
    ]})
]})

% Use helvetica as default font.
\renewcommand{\rmdefault}{phv}
\renewcommand{\sfdefault}{phv}
\renewcommand{\ttdefault}{phv}

\usepackage[dvips]{epsfig}
\usepackage[latin1]{inputenc}
\usepackage{epsfig}
\parskip2ex
\parindent0ex
\sloppy

\begin{document}

    
\title{OO Bench - A Brief Description}
\author{Sven C. K\"ohler}


\maketitle

\begin{center}
There are lies, damned lies, and benchmarks.
\end{center}

\pagebreak

\tableofcontents

\pagebreak


\begin{tabular}{|l||l|l|}
\hline
\multicolumn{3}{|c|}{History} \\
\hline \hline
Date                    & Author                & Description          \\
\hline
2002-01-07              & Sven C. K\"ohler      & Initialization       \\
\hline
2002-08-25              & Sven C. K\"ohler      & Preparation for 0.5.0  \\
\hline
\end{tabular}


\section{Introduction}

\subsection{What is it?}

OO-Bench compares the speed of the same object-oriented tasks in several
object-oriented languages.  It also has a statistics tool (written
in Java), which can be used to easily compare the speed of the several
versions of a given benchmark.  

\subsubsection{Supported Languages so far}

So far supported languages are Java, C++, and Objective-C.  
Also take a look at the \{Java,C++,Objective-C\}/README files.

The directories for CSharp, Eiffel, Smalltalk, and CLOS are already
there, but the benchmarks are currently in development.  

\subsection{Aims}

\begin{itemize}
\item Simple, easy to understand, and easy to port.
\item{ Follows the idioms and best practices advised by each language as
much as possible }
\item{ Designed to make it easy to look up how a particular problem is
best solved in another language }
\end{itemize}

\subsection{Remarks}

\begin{itemize}
\item{ As the motto suggests, the focus is on source code rather than on
benchmark results.  This is even more true, since intensive reviews of the
benchmarks are yet due.  }
\end{itemize}

\subsubsection{About Measuring Time}

To be compatible with Java and Windows, only the actual execution time is
measured (Not the user time of the process).  So try to keep your system
as Idle as possible, and avoid swapping (On UNIX: Watch the pi and po
columns in vmstat during execution of a benchmark).

\subsubsection{About Measuring Memory Usage}

The benchmarks for C++ and Objective-C use sbrk() to monitor heap usage,
that is not supported on all platforms (So you might see no or
inappropriate results for memory allocation).  Also, heaps don't shrink
on most systems, so you won't see memory freed.  Therefore, memory usage
does currently not influence the results produced by the statistics tool.

\subsection{Supported Compilers/Libraries}

OO Bench should work at least with the following compilers, and libraries :

\begin{itemize}
\item C++: GCC-2.95.2 (GCC-3 should work too), to build GNU-Make is needed;
\item ObjC: GCC-2.95.2 with libFoundation, to build GNU-Make is needed;
\item Java: JDK-1.3, to build GNU-Make, ant, and Perl is needed.
\end{itemize}

\section{User Guide}

Usually, one does the following:

\begin{quote}
m4_ifdef({[oob_html]}, {[
\begin{verbatim}
    [oobench-X.Y.Z] $ gmake           # Configure, and compile all files.
    [oobench-X.Y.Z] $ gmake bench     # Run all benchmarks.  Results are
                                      # logged to benchResult.txt.
\end{verbatim}
]}, {[
\begin{tabbing}
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\kill
$[$oobench-X.Y.Z$]$ \$ gmake          \>\# Configure, and compile all files. \\
$[$oobench-X.Y.Z$]$ \$ gmake bench    \>\# Run all benchmarks.  Results are \\
                                  \>\# logged to benchResult.txt. \\
\end{tabbing}
]})
\end{quote}

If you just want to test, whether the benchmarks were compiled correctly,
you can also use the test target:


\begin{quote}
m4_ifdef({[oob_html]}, {[
\begin{verbatim}
[oobench-X.Y.Z] $ gmake test          # Run all benchmarks with minimal    
                                      # values (much faster than the bench
                                      # target).  Results are logged to   
                                      # testResult.txt.                    
\end{verbatim}
]}, {[
\begin{tabbing}
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\kill
$[$oobench-X.Y.Z$]$ \$ gmake test\>\# Run all benchmarks with minimal  \\
                            \>\# values (much faster than the bench \\
                            \>\# target).  Results are logged to \\
                            \>\# testResult.txt. \\
\end{tabbing}
]})
\end{quote}

The bench and test targets can be used in any subdirectory of oobench,
hence you can also do this:
    
\begin{quote}
m4_ifdef({[oob_html]}, {[
\begin{verbatim}
[oobench-X.Y.Z/Java] $ gmake bench  # Run all benchmarks below Java 
                                    # directory.  Results are not
                                    # logged.
\end{verbatim}
]}, {[
\begin{tabbing}
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\kill
$[$oobench-X.Y.Z/Java$]$ \$ gmake bench\>\# Run all benchmarks below Java \\
                                       \>\# directory.  Results are not \\
                                       \>\# logged. \\
\end{tabbing}
]})
\end{quote}

If you want only to execute a certain benchmark, you can do it that way:
    
\begin{quote}
m4_ifdef({[oob_html]}, {[
\begin{verbatim}
[oobench-X.Y.Z/C++/Patterns/MVC] $ gmake bench # Run MVC benchmark only.
                                               # Results are not logged.
\end{verbatim}
]}, {[
\begin{tabbing}
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\kill
$[$oobench-X.Y.Z/C++/Patterns/MVC$]$ \$ gmake bench\>\# Run MVC benchmark only. \\
                                               \>\# Results are not logged. \\
\end{tabbing}
]})
\end{quote}

\subsection{Running the Statistics Program}

USAGE: ./tools/Statistics/statistics $<$ID file$>$ $<$log file[,tag]$>$
[$<$log file[,tag]$>$ ...]

\subsubsection{IDs file}

The IDs file, which is located in the the oobench-X.Y.Z directory,
contains a short description of each benchmark topic, which is then used by
the statistics program when generating the report .

\subsubsection{Tag}

This can be used, if you want to compare several bench results, that use
i. e. the same language, or cannot be distinguished for some other reason.  

Example: You have one benchResult.txt that used JDK-1.3, and one
that used JDK-1.4.  In this case, you can use the ",tag" notation, so the
statistics program can distinguish the two set of results. 

\subsubsection{Example Run}

\begin{verbatim}
[oobench-X.Y.Z] $ ./tools/Statistics/statistics IDs benchResult.txt

Output looks like this:

#
# Output generated by OO Bench's statistics program.
# See http://oobench.sourceforge.net/ for more information
# about OO Bench.
#
# Command was: ./tools/Statistics/statistics IDs benchResult.linux.txt
#
# Note: Performance is measured only by the speed of execution.
#       Estimated times are not included in statistics as well.
=========================================================================
Total average performance (if comparison was available):
C++:  88%
Java: 43%
ObjC: 36%
=========================================================================
[1    ] Data structures benchmarks
Average performance for this section (if comparison was available):
-------------------------------------------------------------------
C++:  84%
Java: 30%
ObjC: 17%
[...]

\end{verbatim}


m4_ifdef({[to_be_done]}, {[
    \section{Data structures benchmarks [ID: 1]}

    \subsection{Vector [ID: 1.1]}

    \subsection{Lists [ID: 1.2]}

    \subsection{Map [ID: 1.3]}

    \subsection{Set [ID: 1.4]}

    \subsection{Array List (Java only) [ID: 1.5]}

    \subsection{Tree Map (Java only) [ID: 1.6]}

    \subsection{Tree Set (Java only) [ID: 1.7]}

    \subsection{HashSet(101, 1f) (Java only) [ID: 1.14]}

    \subsection{HashSet(500000, 0.75f) (Java only) [ID: 1.15]}

    \subsection{HashSet(2, 0.1f) (Java only) [ID: 1.16]}

    \subsection{HashSet(2, 1f) (Java only) [ID: 1.17]}

    \section{C++ Algorithm Benchmarks [ID: 2]}

    \subsection{Function Object [ID: 2.1]}

    \subsection{Without Function Object [ID: 2.2]}

    \subsection{Algorithms  [ID: 2.3]}

    \section{Exceptions [ID: 3]}

    \subsection{Without Exceptions [ID: 3.1]}

    \subsection{With Exceptions (C++: -O0 because of compilation bug) [ID: 3.2]}

    \section{IO Benchmarks [ID: 4]}

    \subsection{Async IO: Large Files [ID: 4.1]}

    \subsection{Async IO: Small Files [ID: 4.2]}

    \subsection{Ansi-C IO: Large Files [ID: 4.3]}

    \subsection{Ansi-C IO: Small Files [ID: 4.4]}

    \subsection{mmap performance: Large Files [ID: 4.5]}

    \subsection{mmap performance: Small Files [ID: 4.6]}

    \subsection{Synchronized Performance: Large Files [ID: 4.7]}

    \subsection{Synchronized Performance: Small Files [ID: 4.8]}

    \subsection{STL Stream Performance: Large Files [ID: 4.9]}

    \subsection{STL Stream Performance: Small Files [ID: 4.10]}

    \section{Messaging [ID: 5]}

    \subsection{Static  [ID: 5.1]}

    \subsection{Virtual  [ID: 5.2]}

    \subsection{Static Final (Java) [ID: 5.3]}

    \subsection{Inlined (C++) [ID: 5.4]}

    \section{Thread Creation [ID: 6]}

    \subsection{Thread Creation [ID: 6.1]}

    \subsection{Thread Contention [ID: 7]}

    \section{Patterns [ID: 8]}

    \subsection{MVC Pattern (C++: -O0 because of compilation bug) [ID: 8.1]}

    \subsection{Generic Proxy [ID: 8.2]}

    \subsection{Flyweight [ID: 8.3]}

    \section{Sorting [ID: 9]}

    \subsection{Array List [ID: 9.1]}

    \subsection{Hash Set [ID: 9.2]}

    \subsection{Linked List [ID: 9.3]}

    \subsection{Tree Map [ID: 9.4]}

    \subsection{Tree Set [ID: 9.5]}

    \subsection{Hash Map [ID: 9.6]}

    \subsection{Array [ID: 9.7]}

    \section{Object Persistence [ID: 10]}

    \subsection{SerializationPerformanceSimpleVersioned [ID: 10.1]}

    \subsection{SerializationPerformanceSimple [ID: 10.2]}

    \subsection{SerializationPerformanceComplexVersioned [ID: 10.3]}

    \subsection{SerializationPerformanceComplex [ID: 10.4]}

    \section{Class Loading [ID: 11]}

    \subsection{Normal [ID: 11.1]}

    \subsection{Jars [ID: 11.2]}

    \subsection{Signed Jars [ID: 11.3]}

    \section{RMI [ID: 12]}

    \subsection{Simple [ID: 12.1]}

    \subsection{Simple SSL [ID: 12.2]}

    \section{CORBA [ID: 13]}

    \subsection{Simple [ID: 13.1]}

    \section{EJB [ID: 14]}

    \subsection{Session Stateful Simple [ID: 14.1]}
]}, {[]})

\end{document}
