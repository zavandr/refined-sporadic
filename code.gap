###
##  This code for GAP ( version 4.14.0 of 2024-12-05 ) accompanies the paper
##  
##  "Refined conjugate generation in sporadic groups"
## 
##  by Danila O. Revin and Andrei V. Zavarnitsine
##
##  Date: May 11, 2025

###
##  Each section of the following code can be copy-pasted into a working GAP session.
##  The output of a command is given after a single '#'.
##  A comment is given after a double '#'.

##
## Section. Elements of order bigger than 2

## We consider the exceptional pairs (S,mX) with m > 2  and  α(x) > 2 from Theorem 1 [check reference !!!]
## and find prime divisors r of |S| with nonzero multiplication coefficients ( mX, mX, nX ) for n divisible by r.

## Column 3 of Table 2 [check reference !!!] of the paper is based on these calculations

## First, we deal with the elements of order m = 3 :
## Namely, for every exceptional pair (S,3X) we find all prime divisors r of |S|
## such that r ≠ 3 and the product of some two representatives of 3X has order divisible by r


pairs := [ ["J2","3a"],   ["McL","3a"],  ["Ly","3a"],   ["Co1","3a"],             ## Exceptional pairs [ <group_name>, <class_name_3X> ]
           ["Fi22","3a"], ["Fi22","3b"], ["Fi23","3a"], ["Fi23","3b"],            ## with <group_name> being GAP's name of S and
           ["F3+","3a"],  ["F3+","3b"],  ["Suz","3a"]  ];;                        ## <class_name_3X> the name of class 3X


result:=[];                                                                       ## a list to collect the total result. Each member of this list is a quadruple
                                                                                  ## [ <group_name>, <class_name_3X>, <FoundPrimes>, <OtherPrimes>], where 
                                                                                  ##  <group_name> and <class_name_3X> are as above,
                                                                                  ##  <FoundPrimes> is the list of prime divisors r ≠ 3 of |S| such that 
                                                                                  ##  the product of some two representatives of 3X has order divisible by r,
                                                                                  ##  <OtherPrimes> is the prime divisors ≠ 3 of |S| not in <FoundPrimes>

for pair in pairs do 

   CharTable := CharacterTable( pair[1] );                                        ## character table of current group 

   ClassNamesG := ClassNames( CharTable );                                        ## names of conjugacy classes of current group

   NumClasses := Size( ClassNamesG );                                             ## number of conjugacy classes   

   pos_3X := Position( ClassNamesG, pair[2] );                                    ## position of class 3X

   OrdersReps := OrdersClassRepresentatives( CharTable );                         ## orders of conjugacy class representatives

   AllPrimesNot3 := Set( Filtered( OrdersReps,         
                               o -> IsPrime(o) and not o = 3 ) );                 ## prime divisors other than 3 of the order of current group

   PositionsNonZero := Filtered( [ 1..NumClasses ],  pos_nX -> 
  
     ClassMultiplicationCoefficient( CharTable, pos_3X, pos_3X, pos_nX ) <> 0 );  ## positions of classes nX with nonzero coefficients m(3X,3X,nX)
   
   OrderFactors := List( OrdersReps{PositionsNonZero}, Factors );                 ## factorized orders of elements in found classes
    
   FoundPrimesNot3 := Difference( Union(OrderFactors), [1,3]);                    ## prime divisors other than 3 of found orders

     
   OtherPrimesNot3 := Difference( AllPrimesNot3, FoundPrimesNot3 );               ## remaining primes ≠ 3
  
   Add( result, [ pair[1], pair[2] , FoundPrimesNot3, OtherPrimesNot3 ]);         ## collect the result
 
od;

Perform(result,function(tup) Print(tup,"\n"); end);                               ## print the result

# [ "J2", "3a", [ 2, 5 ], [ 7 ] ]
# [ "McL", "3a", [ 2, 5 ], [ 7, 11 ] ]
# [ "Ly", "3a", [ 2, 5 ], [ 7, 11, 31, 37, 67 ] ]
# [ "Co1", "3a", [ 2, 5 ], [ 7, 11, 13, 23 ] ]
# [ "Fi22", "3a", [ 2, 5 ], [ 7, 11, 13 ] ]
# [ "Fi22", "3b", [ 2, 5, 7, 13 ], [ 11 ] ]
# [ "Fi23", "3a", [ 2, 5 ], [ 7, 11, 13, 17, 23 ] ]
# [ "Fi23", "3b", [ 2, 5, 7, 13 ], [ 11, 17, 23 ] ]
# [ "F3+", "3a", [ 2, 5 ], [ 7, 11, 13, 17, 23, 29 ] ]
# [ "F3+", "3b", [ 2, 5, 7, 13 ], [ 11, 17, 23, 29 ] ]
# [ "Suz", "3a", [ 2, 5 ], [ 7, 11, 13 ] ]


## We now deal with elements of order m = 4 :
## Namely, for every exceptional pair (Aut(S),4X) we find all odd prime divisors r of |S|
## such that the product of some two representatives of 4X has order divisible by r


pairs := [ ["HS","4a"], ["HN.2","4d"] ];;                                         ##  Exceptional pairs [ <group_name>, <class_name_4X> ]
                                                                                  ##  with <group_name> being GAP's name of S and 
                                                                                  ##  <class_name_4X> the name of class 4X

result:=[];                                                                       ## a list to collect the total result. Each member of this list is a ....
                                                                                  ## [ <group_name>, <class_name_4X>, <FoundPrimes>, <OtherPrimes>], where 
                                                                                  ##  <group_name> and <class_name_4X> are as above,
                                                                                  ##  <FoundPrimes> is the list of odd prime divisors r of |S| such that 
                                                                                  ##  the product of some two representatives of 4X has order divisible by r,
                                                                                  ##  <OtherPrimes> is the odd prime divisors of |S| not in <FoundPrimes>

for pair in pairs do 

   CharTable := CharacterTable( pair[1] );                                        ## character table of current group 

   ClassNamesG := ClassNames( CharTable );                                        ## names of conjugacy classes of current group

   NumClasses := Size( ClassNamesG );                                             ## number of conjugacy classes   

   pos_4X := Position( ClassNamesG, pair[2] );                                    ## position of class 4X

   OrdersReps := OrdersClassRepresentatives( CharTable );                         ## orders of conjugacy class representatives

   AllOddPrimes := Set( Filtered( OrdersReps,         
                               o -> IsPrime(o) and not o = 2 ) );                 ## odd prime divisors of the order of current group

   PositionsNonZero := Filtered( [ 1..NumClasses ],  pos_nX -> 
  
     ClassMultiplicationCoefficient( CharTable, pos_4X, pos_4X, pos_nX ) <> 0 );  ## positions of classes nX with nonzero coefficients m(4X,4X,nX)
   
   OrderFactors := List( OrdersReps{PositionsNonZero}, Factors );                 ## factorized orders of elements in found classes
    
   FoundOddPrimes := Difference( Union(OrderFactors), [1,2]);                     ## odd prime divisors of found orders

     
   OtherOddPrimes := Difference( AllOddPrimes, FoundOddPrimes );                  ## remaining odd primes
  
   Add( result, [ pair[1], pair[2] , FoundOddPrimes, OtherOddPrimes ]);           ## collect the result
 
od;

Perform(result,function(tup) Print(tup,"\n"); end);                               ## print the result

# [ "HS", "4a", [ 3, 5, 7 ], [ 11 ] ]
# [ "HN.2", "4d", [ 3, 5, 7 ], [ 11, 19 ] ]

####
## Section. Proof of Lemma \ref{more_alpha}
##

###  Case S = U5(2) 

## First, we show that α( U5(2), 3C ) ⩽ 3 

CharTab_U5_2 := CharacterTable("U5(2)");;                                                        ##  character table of U5(2)

ClassMultiplicationCoefficient( CharTab_U5_2, CharTab_U5_2.3c, CharTab_U5_2.3c,  CharTab_U5_2.12a );  #  16     ##  = m( 3C,  3C, 12A )
ClassMultiplicationCoefficient( CharTab_U5_2, CharTab_U5_2.3c, CharTab_U5_2.12a, CharTab_U5_2.11a );  #  22     ##  = m( 3C, 12A, 11A )

## As the only maximal subgroup of U5(2) of order divisible by 11 is L2(11)
## which contains no elements of order 12, there are three elements in class 3C
## that generate the whole of U5(2). Therefore, α( U5(2), 3C ) ⩽ 3 

## We now show that α( U5(2), 3C ) > 2

NrClasses_U5_2 := Size( Irr( CharTab_U5_2 ) );;                                                          ## number of conjugacy classes  

ListMCentr := List( [1..NrClasses_U5_2], n ->                                                            ## list of pairs [ m( 3C, 3C, nX ), |C(x)| ] 
     [ ClassMultiplicationCoefficient( CharTab_U5_2, CharTab_U5_2.3c, CharTab_U5_2.3c, n ),              ##           with x ∊ nX for every class nX 
       SizesCentralizers( CharTab_U5_2 )[n]
     ] );

# [ [ 0, 13685760 ], [ 0, 82944 ], [ 0, 4608 ], [ 240, 77760 ], [ 0, 77760 ], [ 0, 3888 ], [ 82, 3888 ], [ 0, 1944 ], [ 2, 324 ], [ 0, 1152 ], [ 0, 384 ], 
#   [ 0, 96 ], [ 0, 15 ], [ 0, 1728 ], [ 0, 1728 ], [ 0, 1296 ], [ 36, 1296 ], [ 0, 432 ], [ 6, 432 ], [ 24, 288 ], [ 0, 288 ], [ 0, 216 ], [ 0, 144 ], [ 0, 144 ], 
#   [ 0, 108 ], [ 6, 108 ], [ 0, 36 ], [ 0, 16 ], [ 0, 54 ], [ 0, 54 ], [ 0, 27 ], [ 0, 27 ], [ 0, 11 ], [ 0, 11 ], [ 16, 144 ], [ 0, 144 ], [ 0, 72 ], 
#   [ 0, 72 ], [ 0, 36 ], [ 0, 24 ], [ 0, 24 ], [ 0, 24 ], [ 6, 24 ], [ 0, 15 ], [ 5, 15 ], [ 0, 18 ], [ 0, 18 ] ]

## Checking if the inequality from Theorem \ref{DiM_Zal} is satisfied for each triple ( 3C, 3C, nX ) :

ForAll( ListMCentr, l -> l[1] < l[2] );   # true

## Obs. We did not exclude the classes nX with m( 3C, 3C, nX ) = 0 for which there are no x,y ∊ 3C
##       with xy ∊ nX because the required inequality is obviously satisfied in these cases.  

## => Theorem \ref{DiM_Zal} implies that U5(2) cannot be generated by two elements in 3C, and so α( U5(2), 3C ) > 2

## Conclusion: We have shown that α( U5(2), 3C ) = 3 
###

###  Case S = U6(2) 

###
## We first prove that α( U6(2), 3b ) ⩽ 3 
## by finding explicilty 3 generators of U6(3) in class 3b

U6_2 := AtlasGroup("U6(2)");
# <permutation group of size 9196830720 with 2 generators>
gens := GeneratorsOfGroup(U6_2);;    
a := gens[1];; b:= gens[2];;              ## standard generators of U6(2) 

x := (a*b^2) ^ 6;;
Order( x );                     # 3
Size( Centralizer( U6_2, x ) ); # 46656   ## this confirms that x is in class 3b

Size( Group( x, x^a, x^b ) );
# 9196830720                              ## = |U6(2)|

## This proves that α( U6(2), 3b ) ⩽ 3 
###

###
##  We find all possibilities for S = U6(2) to be ( 3b, 3b; nX )-generated using 
##  the Di Martino--Pellegrini--Zalesski inequality  
##   m( 3b, 3b, nX ) >= |C_S(x)| with x in nX

CharTab_U6_2 := CharacterTable("U6(2)");;

ClNames_U6_2 := ClassNames(CharTab_U6_2);;                           ## names of conjugacy classes
NrClasses_U6_2 := Size(ClNames_U6_2);

PosIneqHolds := Filtered( [1..NrClasses_U6_2], n ->                  ## positions of classes nX for which m( 3b, 3b, nX ) >= |C_S(x)|
   ClassMultiplicationCoefficient( CharTab_U6_2, CharTab_U6_2.3b, CharTab_U6_2.3b, n ) >= 
                         SizesCentralizers( CharTab_U6_2 )[n] );;

ClNames_U6_2{PosIneqHolds}; # [ "7a", "9c" ]                         ## found classes nX 

## Conclusion: U6(2) may only be ( 3b, 3b; nX )-generated for nX = 7a or 9c 
###

###
##  Checking that in SU6(2), we have  
##
##  m( 3f, 3f, 7a )  > 0 
##  m( 3f, 3f, 21a ) = 0 
##  m( 3f, 3f, 21b ) = 0 
##
## as claimed in the proof of subcase nX=7A of Lemma  \ref{more_alpha}

CharTab_3_U6_2 := CharacterTable("3.U6(2)");;                        ## character table of SU6(2)
ClassMultiplicationCoefficient( CharTab_3_U6_2, CharTab_3_U6_2.3f, CharTab_3_U6_2.3f, CharTab_3_U6_2.7a );    # 7    
ClassMultiplicationCoefficient( CharTab_3_U6_2, CharTab_3_U6_2.3f, CharTab_3_U6_2.3f, CharTab_3_U6_2.21a );   # 0
ClassMultiplicationCoefficient( CharTab_3_U6_2, CharTab_3_U6_2.3f, CharTab_3_U6_2.3f, CharTab_3_U6_2.21b );   # 0

## Conclusion: U6(2) may only be ( 3b, 3b; nX )-generated for nX = 7a or 9c 
###
### The claim holds


### Section. Elements of order bigger than 2
##
## In this section, we find various class fusions that are claimed to hold 
## in Section "Elements of order bigger than 2" [ check reference !!!] of the paper
##

##
##  1. Fusions into class 3B of Fi_22 from its maximal subgroups 2.U6(2), 2^10:M22, and M12  
## 

CharTable_Fi22     := CharacterTable( "Fi22" );;                                    ## character tables
CharTable_2U6_2    := CharacterTable("Fi22M1");  #  CharacterTable( "2.U6(2)"  )    ## of Fi22     
CharTable_2e10M22  := CharacterTable("Fi22M5");  #  CharacterTable( "2^10:m22" )    ## and its maximal subgroups 
CharTable_M12      := CharacterTable("Fi22M14"); #  CharacterTable( "M12" )         ## 2.U6(2), 2^10:M22, and M12  


ClNames_Fi22    := ClassNames( CharTable_Fi22    );;                                ## names 
ClNames_2U6_2   := ClassNames( CharTable_2U6_2   );;                                ## of conjugacy
ClNames_2e10M22 := ClassNames( CharTable_2e10M22 );;                                ## classes
ClNames_M12     := ClassNames( CharTable_M12     );;                                ## 

NrClasses_2U6_2   := Size( ClNames_2U6_2   );   # 77                                ## numbers of
NrClasses_2e10M22 := Size( ClNames_2e10M22 );   # 43                                ## conjugacy 
NrClasses_M12     := Size( ClNames_M12     );   # 15                                ## classes 

PosClasses3_2U6_2    :=  Filtered( [1..NrClasses_2U6_2  ],                          ## positions of
                   n -> OrdersClassRepresentatives(CharTable_2U6_2  )[n] = 3 );;    ## conjugacy
PosClasses3_2e10M22  :=  Filtered( [1..NrClasses_2e10M22],                          ## classes  
                   n -> OrdersClassRepresentatives(CharTable_2e10M22)[n] = 3 );;    ## of elements                  
PosClasses3_M12      :=  Filtered( [1..NrClasses_M12    ],                          ## of order 3  
                   n -> OrdersClassRepresentatives(CharTable_M12    )[n] = 3 );;    ##                    

ClNames_2U6_2  { PosClasses3_2U6_2   };   #   [ "3a", "3b", "3c" ]                  ## names of conjugacy 
ClNames_2e10M22{ PosClasses3_2e10M22 };   #   [ "3a" ]                              ## classes of elements 
ClNames_M12    { PosClasses3_M12     };   #   [ "3a", "3b" ]                        ## of order 3

PCFs_2U6_2   := PossibleClassFusions( CharTable_2U6_2  , CharTable_Fi22 );;         ## possible class fusions
PCFs_2e10M22 := PossibleClassFusions( CharTable_2e10M22, CharTable_Fi22 );;         ## from maximal subgroups
PCFs_M12     := PossibleClassFusions( CharTable_M12    , CharTable_Fi22 );;         ## into Fi22

## Printing fusions of elements of order 3 into Fi22

## Fusion for 2.U6(2) :

for pos in PosClasses3_2U6_2 do
   Print( "  ", ClNames_2U6_2[pos], " -> ", Set( PCFs_2U6_2, cf -> ClNames_Fi22[ cf[ pos ] ]), "\n"  );
od;

#  3a -> [ "3a" ]
#  3b -> [ "3b" ]   
#  3c -> [ "3c" ]        ##  Conclusion:  Only 3b of 2.U6(2) fuses into 3B of Fi22


## Fusion for 2^10:M22 :

for pos in PosClasses3_2e10M22 do
   Print( "  ", ClNames_2e10M22[pos], " -> ", Set( PCFs_2e10M22, cf -> ClNames_Fi22[ cf[ pos ] ]), "\n"  );
od;

#  3a -> [ "3c" ]        ##  Conclusion:  No fusion from 2^10:M22 into 3B of Fi22


## Fusion for M12 :

for pos in PosClasses3_M12 do
   Print( "  ", ClNames_M12[pos], " -> ", Set( PCFs_M12, cf -> ClNames_Fi22[ cf[ pos ] ]), "\n"  );
od;

#  3a -> [ "3d" ]
#  3b -> [ "3c" ]        ##  Conclusion:  No fusion from M12 into 3B of Fi22

##
##  2. Fusions into class 3B of U6(2) from its maximal subgroups U5(2) and M12  
## 

CharTable_U6_2 := CharacterTable( "U6(2)" );;                             ## character tables
CharTable_U5_2 := CharacterTable( "U5(2)" );;                             ## of U6(2)     
CharTable_M22  := CharacterTable( "M22"   );;                             ## and its maximal


ClNames_U6_2 := ClassNames( CharTable_U6_2 );;                            ## names 
ClNames_U5_2 := ClassNames( CharTable_U5_2 );;                            ## of conjugacy
ClNames_M22  := ClassNames( CharTable_M22  );;                            ## classes

NrClasses_U5_2 := Size( ClNames_U5_2 );  #  47                            ## numbers of
NrClasses_M22  := Size( ClNames_M22  );  #  12                            ## conjugacy 

PosClasses3_U5_2 := Filtered( [1..NrClasses_U5_2  ],                           ## positions of
               n -> OrdersClassRepresentatives( CharTable_U5_2 )[n] = 3  );;   ## conjugacy classes
PosClasses3_M22  := Filtered( [1..NrClasses_M22],                              ## of elements
               n -> OrdersClassRepresentatives( CharTable_M22 )[n] = 3  );;    ## of order 3  

ClNames_U5_2{ PosClasses3_U5_2 };                                         ##
# [ "3a", "3b", "3c", "3d", "3e", "3f" ]                                  ## names of conjugacy classes 
ClNames_M22 { PosClasses3_M22  };                                         ## of elements of order 3 
# [ "3a" ]                                                                ##

PCFs_U5_2 := PossibleClassFusions( CharTable_U5_2  , CharTable_U6_2 );;   ## possible class fusions
PCFs_M22  := PossibleClassFusions( CharTable_M22, CharTable_U6_2 );;      ## from maximal subgroups


## Printing fusions of elements of order 3 into U6(2)

## Fusion for U5(2) :

for pos in PosClasses3_U5_2 do
   Print( "  ", ClNames_U5_2[pos], " -> ", Set( PCFs_U5_2, cf -> ClNames_U6_2[ cf[ pos ] ]), "\n"  );
od;

#  3a -> [ "3a" ]
#  3b -> [ "3a" ]
#  3c -> [ "3b" ]
#  3d -> [ "3b" ]
#  3e -> [ "3a" ]
#  3f -> [ "3c" ]     ##  Conclusion:  Classes 3c and 3d of U5(2) fuse into 3B of U6(2)

## Fusion for M22 :

for pos in PosClasses3_M22 do
   Print( "  ", ClNames_M22[pos], " -> ", Set( PCFs_M22, cf -> ClNames_U6_2[ cf[ pos ] ]), "\n"  );
od;

#  3a -> [ "3c" ]      ##  Conclusion:   No fusion from M22 into 3B of U6(2)


##
##  3. Fusions into classes 3B and 3C of U5(2) from its maximal subgroup L2(11)
## 


CharTable_U5_2  := CharacterTable( "U5(2)"  );;                                 ## character tables of U5(2)
CharTable_L2_11 := CharacterTable( "L2(11)" );;                                 ## and its maximal subgroup L2(11)

ClNames_U5_2 := ClassNames( CharTable_U5_2 );;                                  ## names 
ClNames_L2_11 := ClassNames( CharTable_L2_11 );;                                ## of conjugacy classes

NrClasses_L2_11 := Size( ClNames_L2_11 );  #  8                                 ## number of conjugacy 

PosClasses3_L2_11 := Filtered( [1..NrClasses_L2_11  ],                          ## positions of conjugacy
               n -> OrdersClassRepresentatives( CharTable_L2_11 )[n] = 3  );;   ## classes of elements of order 3

ClNames_L2_11{ PosClasses3_L2_11 }; #  [ "3a" ]                                 ## names of conjugacy classes 
                                                                                ## of elements of order 3 

PCFs_L2_11 := PossibleClassFusions( CharTable_L2_11  , CharTable_U5_2 );;       ## possible class fusions from maximal subgroup


## Printing fusions from L2(11) of elements of order 3 into U5(2) 

for pos in PosClasses3_L2_11 do
   Print( "  ", ClNames_L2_11[pos], " -> ", Set( PCFs_L2_11, cf -> ClNames_U5_2[ cf[ pos ] ]), "\n"  );
od;

#   3a -> [ "3f" ]    ##  Conclusion:   No fusion from L2(11) into either 3B or 3C of U5(2)

###
#####


