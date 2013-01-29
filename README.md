TechChallengeFactors
====================

Leading EDJE TechChallengeFactors
See  - https://sites.google.com/a/leadingedje.com/techchallengefactors/?pli=1 for details about this challenge.

Requirements
------------
1. Mac running OS X Mountain Lion
2. Xcode 4.5 or Xcode 4.6

Build Instructions
------------------
1. Download this project from GitHub
2. Open TechChallengeFactors.xcodeproj inside Xcode 4.5 or Xcode 4.6
3. Select Product -> Clean from Xcode's menu bar
4. Select Product -> Build For -> Archiving from the menu bar

Execution Instructions
----------------------
1. Build the project (see build instructions above)
2. Open a Terminal window
3. Run the command cd ~/Library/Developer/Xcode/DerivedData
4. At the prompt, enter cd TechChallengeFactors and then, press the Tab key
   to complete the directory.  Then, press Enter.
5. Run the command cd Build/Products/Release/
6. Run ./TechChallengeFactors <factors.txt> replacing <factors.txt> with
   the fully qualified path to factors.txt downloaded from the
   challenge link above.  The results will be written to factorsresult.txt
   inside the current directory.
   
