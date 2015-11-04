# TutorialTimeSlotScheduler

<h2>A Prolog program which is capable of proposing the LEAST number of tutorial time slots to ensure EVERY student can attend AT LEAST ONE tutorial and EVERY tutors can attend ALL the tutorials.</h2>
<h3>I wrote this program for an assignment in my AI course, it took me a day to learn the language and write this program so the code is undoubtedly crappy. I put it here just for future reference.</h3>
<ul>
  <li>A Prolog predicate was implemented to acheieve the desired result:</li>
  <ul>
    <li>find_time_slots(ConstraintLabels,StudentIDs,NumOfTutorials,TutorialTime).</li>
    <ul>
      <li>ConstraintLabels: a list of the constraint labels C of constraints on the timetable</li>
      <li>StudentIDs: a list of the student identifiers S of students on the timetable</li>
      <li>NumOfTutorials: the minimum number of tutorials Nmin offered</li>
      <li>TutorialTime: a list representing the tutorial timetable T with the minimum number of tutorials offered to students</li>
    </ul>
  </ul>
  <li>Constraints on Tutorial Timeslots</li>
  <ul>
    <li>constraints(Constraint_label,T).</li>
    <ul>
      <li>Constraint_label: a Prolog atom storing the label of the constraints</li>
      <li>T: a list of {a, n}N indicating the time slots allowed to hold tutorials, atom “a” and “n” means the tutor can hold and cannot hold the tutorial session respectively.</li>
      <li>Exemple:</li>
      <ul>
        <li>constraints(alice_tt,[n,n,a,n,n,a,a,a,a,a,a,n,n,n,a]).</li>
        <li>constraints(bob_tt,[n,a,n,n,n,a,n,n,a,a,a,n,a,a,a]).</li>
        <li>The above shows whether Alice and Bob can hold tutorials on a list of timeslots. Please note that there is no specific order and no specific requirement on the number of timeslots on the list. For example, the first element can represent “M1” or “T1” or “W5”. Some timeslots has been omitted due to some reasons (say, conflicts with the lectures). However, it should be noted that any two lists must have the same representation and contain the same number of elements. For example, if the first element of Alice’s Timetable indicates if she can hold tutorial on M4, the first element of Bob’s Timetable (and the others’) will have the same meaning.</li>
      </ul>
    </ul>
  </ul>
  <li>Student Timetable</li>
  <ul>
    <li>student_timetable(Sid,T).</li>
    <ul>
      <li>Sid: a Prolog atom storing the student ID</li>
      <li>T: a list of {a, n}N corresponding to timetable of student with student ID Sid, “a” and “n” means a student can attend and cannot attend the tutorial session respectively, where the underlying representation is the same as the constraint lists.</li>
      <ul>
        <li>student_timetable(s1267633431,[a,a,a,n,n,a,n,n,a,a,a,n,n,a,a]).</li>
        <li>student_timetable(s1246634324,[n,a,n,n,a,a,n,a,n,a,n,n,a,a,n]).</li>
      </ul>
    </ul>
  </ul>
  <li>Example Input:</li>
  <ul>
    <li>constraints(alice_tt,[n,n,a,n,n,a,a,a,a,a,a,n,n,n]).<br>
        constraints(bob_tt,[n,a,n,n,n,a,n,n,a,a,a,n,a,a]).<br>
        student_timetable(s12676,[a,a,a,n,n,a,n,n,a,a,a,n,n,a]).<br>
        student_timetable(s12466,[n,a,n,n,a,a,n,a,n,a,n,n,a,a]).</li>
  </ul>
  <li>Example Output:</li>
  <ul>
    <li>?- find_time_slots([alice_tt, bob_tt],[s12676,s12466],NumTuto,Tuto).<br>
        NumTuto = 1,<br>
        Tuto = [n, n, n, n, n, a, n, n, n, n, n, n, n, n].</li>
  </ul>
</ul>
