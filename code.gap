###
##  This code for GAP ( version 4.15.1 of 2025-10-18 ) accompanies the paper
##  
##  "Refined conjugate generation in sporadic groups"
## 
##  by Danila O. Revin and Andrei V. Zavarnitsine
##
##  Date: February 2, 2026

###
##  Each section of the following code can be copy-pasted into a working GAP session.
##  GAP's output of a command is given after a single '#'.
##  A comment is given after a double '#'.

###
## Section 1. 
##
## We consider the exceptional pairs (S,mX) with m > 2  and  α(x) > 2 from Proposition 3 and find 
## the prime divisors r of |S| with nonzero multiplication coefficients ( mX, mX, nX ) for n divisible by r.
##
## Column 3 of Table 1 of the paper is based on these calculations
##
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

for pair in pairs do                                                              ## running through all exceptional pairs

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

Perform( result, function(tup) Print(tup,"\n"); end );                            ## print the result

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

result:=[];                                                                       ## a list to collect the total result. Each member of this list is a quadruple
                                                                                  ## [ <group_name>, <class_name_4X>, <FoundPrimes>, <OtherPrimes>], where 
                                                                                  ##  <group_name> and <class_name_4X> are as above,
                                                                                  ##  <FoundPrimes> is the list of odd prime divisors r of |S| such that 
                                                                                  ##  the product of some two representatives of 4X has order divisible by r,
                                                                                  ##  <OtherPrimes> is the odd prime divisors of |S| not in <FoundPrimes>

for pair in pairs do                                                              ## running through all exceptional pairs

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
    
   FoundOddPrimes := Difference( Union(OrderFactors), [1,2] );                    ## odd prime divisors of found orders

     
   OtherOddPrimes := Difference( AllOddPrimes, FoundOddPrimes );                  ## remaining odd primes
  
   Add( result, [ pair[1], pair[2] , FoundOddPrimes, OtherOddPrimes ]);           ## collect the result
 
od;

Perform(result,function(tup) Print(tup,"\n"); end);                               ## print the result

# [ "HS", "4a", [ 3, 5, 7 ], [ 11 ] ]
# [ "HN.2", "4d", [ 3, 5, 7 ], [ 11, 19 ] ]
##
###

### 
## Section 2.
##
## We show that α( U5(2), 3C ) ⩽ 3  
## 

CharTab_U5_2 := CharacterTable("U5(2)");;                                                        ##  character table of U5(2)

ClassMultiplicationCoefficient( CharTab_U5_2, CharTab_U5_2.3c, CharTab_U5_2.3c,  CharTab_U5_2.12a );  #  16     ##  = m( 3C,  3C, 12A )
ClassMultiplicationCoefficient( CharTab_U5_2, CharTab_U5_2.3c, CharTab_U5_2.12a, CharTab_U5_2.11a );  #  22     ##  = m( 3C, 12A, 11A )

## As the only maximal subgroup of U5(2) of order divisible by 11 is L2(11)
## which contains no elements of order 12, there are three elements in class 3C
## that generate the whole of U5(2). Therefore, α( U5(2), 3C ) ⩽ 3 

### 
## Section 3.
##
##  We now show that α( U5(2), 3C ) > 2
##  

NrClasses_U5_2 := Size( Irr( CharTab_U5_2 ) );;                                                          ## number of conjugacy classes  

ListMCentr := List( [1..NrClasses_U5_2], n ->                                                            ## list of pairs [ m( 3C, 3C, nX ), |C(x)| ] 
     [ ClassMultiplicationCoefficient( CharTab_U5_2, CharTab_U5_2.3c, CharTab_U5_2.3c, n ),              ##           with x ∊ nX for every class nX 
       SizesCentralizers( CharTab_U5_2 )[n]
     ] );

# [ [ 0, 13685760 ], [ 0, 82944 ], [ 0, 4608 ], [ 240, 77760 ], [ 0, 77760 ], [ 0, 3888 ], [ 82, 3888 ], [ 0, 1944 ], [ 2, 324 ], [ 0, 1152 ], [ 0, 384 ], 
#   [ 0, 96 ], [ 0, 15 ], [ 0, 1728 ], [ 0, 1728 ], [ 0, 1296 ], [ 36, 1296 ], [ 0, 432 ], [ 6, 432 ], [ 24, 288 ], [ 0, 288 ], [ 0, 216 ], [ 0, 144 ], [ 0, 144 ], 
#   [ 0, 108 ], [ 6, 108 ], [ 0, 36 ], [ 0, 16 ], [ 0, 54 ], [ 0, 54 ], [ 0, 27 ], [ 0, 27 ], [ 0, 11 ], [ 0, 11 ], [ 16, 144 ], [ 0, 144 ], [ 0, 72 ], 
#   [ 0, 72 ], [ 0, 36 ], [ 0, 24 ], [ 0, 24 ], [ 0, 24 ], [ 6, 24 ], [ 0, 15 ], [ 5, 15 ], [ 0, 18 ], [ 0, 18 ] ]

## Checking if the inequality from Proposition 1 is satisfied for each triple ( 3C, 3C, nX ) :

ForAll( ListMCentr, l -> l[1] < l[2] );   # true

## Obs. We did not exclude the classes nX with m( 3C, 3C, nX ) = 0 for which there are no x,y ∊ 3C
##       with xy ∊ nX because the required inequality is obviously satisfied in these cases.  

## => Proposition 1 implies that U5(2) cannot be generated by two elements in 3C, and so α( U5(2), 3C ) > 2

## Conclusion: We have shown that α( U5(2), 3C ) = 3 
###


###
## Section 4.
##
## We prove that α( U6(2), 3b ) ⩽ 3 
## by finding explicilty 3 generators of U6(3) in class 3b
## Standard generators of U6(2) are a and b where a is in class 2A, b has order 7, ab has order 11 and abb has order 18.

U6_2 := AtlasGroup("U6(2)");
# <permutation group of size 9196830720 with 2 generators>
Gens_U6_2 := GeneratorsOfGroup(U6_2);;    
a := Gens_U6_2[1];; b:= Gens_U6_2[2];;            ## standard generators of U6(2)
List( [ a, b, a*b, a*b^2 ], Order ); 
# [ 2, 7, 11, 18 ]                                ## this agrees with the definition of standard generators    

x := (a*b^2) ^ 6;;
Order( x );                     # 3
Size( Centralizer( U6_2, x ) ); # 46656   ## this confirms that x is in class 3b

Size( Group( x, x^a, x^b ) );
# 9196830720                              ## = |U6(2)|

## Conclusion : This proves that α( U6(2), 3b ) ⩽ 3 
###

###
## Section 5.
##
##  We find all possibilities for S = U6(2) to be ( 3b, 3b; nX )-generated using 
##  the Di Martino--Pellegrini--Zalesski inequality  
##   m( 3b, 3b, nX ) >= |C_S(x)| with x in nX

CharTab_U6_2 := CharacterTable("U6(2)");;

ClNames_U6_2 := ClassNames(CharTab_U6_2);;                           ## names of conjugacy classes of U6(2)
NrClasses_U6_2 := Size(ClNames_U6_2);                                ## number of conjugacy classes

PosIneqHolds := Filtered( [1..NrClasses_U6_2], n ->                  ## positions of classes nX for which m( 3b, 3b, nX ) >= |C_S(x)|
   ClassMultiplicationCoefficient( CharTab_U6_2, CharTab_U6_2.3b, CharTab_U6_2.3b, n ) >= 
                         SizesCentralizers( CharTab_U6_2 )[n] );;

ClNames_U6_2{PosIneqHolds}; # [ "7a", "9c" ]                         ## found classes nX 

## Conclusion: U6(2) may only be ( 3b, 3b; nX )-generated for nX = 7a or 9c 
###

###
## Section 6.
##
##  Checking that, in SU6(2), we have  
##
##  m( 3f, 3f, 7a )  > 0 
##  m( 3f, 3f, 21a ) = 0 
##  m( 3f, 3f, 21b ) = 0 
##

CharTab_3_U6_2 := CharacterTable("3.U6(2)");;                        ## character table of SU6(2)
ClassMultiplicationCoefficient( CharTab_3_U6_2, CharTab_3_U6_2.3f, CharTab_3_U6_2.3f, CharTab_3_U6_2.7a );    # 7    
ClassMultiplicationCoefficient( CharTab_3_U6_2, CharTab_3_U6_2.3f, CharTab_3_U6_2.3f, CharTab_3_U6_2.21a );   # 0
ClassMultiplicationCoefficient( CharTab_3_U6_2, CharTab_3_U6_2.3f, CharTab_3_U6_2.3f, CharTab_3_U6_2.21b );   # 0

## Conclusion: U6(2) may only be ( 3b, 3b; nX )-generated for nX = 7a or 9c 
###

### 
## Section 7. 
##
##  Fusion into class 3B of Fi_22 from its maximal subgroups 2.U6(2), 2^10:M22, and M12  
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

## 7(a). Fusion for 2.U6(2) :

for pos in PosClasses3_2U6_2 do
   Print( "  ", ClNames_2U6_2[pos], " -> ", Set( PCFs_2U6_2, cf -> ClNames_Fi22[ cf[ pos ] ]), "\n"  );
od;

#  3a -> [ "3a" ]
#  3b -> [ "3b" ]   
#  3c -> [ "3c" ]        ##  Conclusion:  Only 3b of 2.U6(2) fuses into 3B of Fi22


## 7(b). Fusion for 2^10:M22 :

for pos in PosClasses3_2e10M22 do
   Print( "  ", ClNames_2e10M22[pos], " -> ", Set( PCFs_2e10M22, cf -> ClNames_Fi22[ cf[ pos ] ]), "\n"  );
od;

#  3a -> [ "3c" ]        ##  Conclusion:  No fusion from 2^10:M22 into 3B of Fi22


## 7(c). Fusion for M12 :

for pos in PosClasses3_M12 do
   Print( "  ", ClNames_M12[pos], " -> ", Set( PCFs_M12, cf -> ClNames_Fi22[ cf[ pos ] ]), "\n"  );
od;

#  3a -> [ "3d" ]
#  3b -> [ "3c" ]        ##  Conclusion:  No fusion from M12 into 3B of Fi22

###
## Section 8.
##
##  Fusion into class 3b of U6(2) from its maximal subgroups U5(2) and M22  
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

## 8(a). Fusion for U5(2) :

for pos in PosClasses3_U5_2 do
   Print( "  ", ClNames_U5_2[pos], " -> ", Set( PCFs_U5_2, cf -> ClNames_U6_2[ cf[ pos ] ]), "\n"  );
od;

#  3a -> [ "3a" ]
#  3b -> [ "3a" ]
#  3c -> [ "3b" ]
#  3d -> [ "3b" ]
#  3e -> [ "3a" ]
#  3f -> [ "3c" ]     ##  Conclusion:  Classes 3c and 3d of U5(2) fuse into 3b of U6(2)

## 8(b). Fusion for M22 :

for pos in PosClasses3_M22 do
   Print( "  ", ClNames_M22[pos], " -> ", Set( PCFs_M22, cf -> ClNames_U6_2[ cf[ pos ] ]), "\n"  );
od;

#  3a -> [ "3c" ]      ##  Conclusion:   No fusion from M22 into 3B of U6(2)

###
## Section 9.
##
##  Fusion into classes 3c and 3d of U5(2) from its maximal subgroup L2(11)
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

PCFs_L2_11 := PossibleClassFusions( CharTable_L2_11  , CharTable_U5_2 );;       ## possible class Fusion from maximal subgroup


## Printing Fusion from L2(11) of elements of order 3 into U5(2) 

for pos in PosClasses3_L2_11 do
   Print( "  ", ClNames_L2_11[pos], " -> ", Set( PCFs_L2_11, cf -> ClNames_U5_2[ cf[ pos ] ]), "\n"  );
od;

#   3a -> [ "3f" ]    ##  Conclusion:   No fusion from L2(11) into either 3c or 3d of U5(2)

###
#####


### 
## Section 10.
##
##  Checking that there are three elements in 3A of Suz whose product has order 7 and 13
##  as claimed in the proofs of cases  (Suz,3A,r), r = 7, 13

CharTable_Suz  := CharacterTable("Suz");                           ## character tables of Suz

ClassStructureCharTable( CharTable_Suz, [ CharTable_Suz.3a, 
                                          CharTable_Suz.3a, 
                                          CharTable_Suz.3a, 
                                          CharTable_Suz.7a ] );    ##  n( 3A, 3A, 3A, 7A )
# 16738231910400     

## Conclusion:  The product of three elements in 3A of Suz has order 7 
## => β_{Suz,7}(3A) ⩽ 3

ClassStructureCharTable( CharTable_Suz, [ CharTable_Suz.3a, 
                                          CharTable_Suz.3a, 
                                          CharTable_Suz.3a, 
                                          CharTable_Suz.13a ] );    ##  n( 3A, 3A, 3A, 13A )

# 5828491468800

## Conclusion: The product of three elements in 3A of Suz has order 13
## => β_{Suz,13}(3A) ⩽ 3

###  
## Section 11.
##
##   Fusion into class 3A of Suz from its maximal subgroups 
##   G2(4),  3_2.U4(3):2'_3,  U5(2),  3^5:M11,  J2:2,  (A4 × L3(4)):2,  M12:2,  L3(3):2,  L2(25),  A7
## 

CharTable_Suz   := CharacterTable("Suz");;                                         ## character tables of Suz and its maximal subgroups
CharTable_G2_4  := CharacterTable("SuzM1");  # CharacterTable( "G2(4)" )           ## G2(4),
CharTable_SuzM2 := CharacterTable("SuzM2");  # CharacterTable( "3_2.U4(3).2_3'" )  ## 3_2.U4(3):2'_3,
CharTable_U5_2  := CharacterTable("SuzM3");  # CharacterTable( "U5(2)" )           ## U5(2),
CharTable_SuzM5 := CharacterTable("SuzM5");  # CharacterTable( "3^5:M11" )         ## 3^5:M11,
CharTable_SuzM6 := CharacterTable("SuzM6");  # CharacterTable( "J2.2" )            ## J2:2,
CharTable_SuzM8 := CharacterTable("SuzM8");  # CharacterTable( "(a4xpsl(3,4)):2" ) ## (A4 x L3(4)):2,
CharTable_SuzM10:= CharacterTable("SuzM10"); # CharacterTable( "M12.2" )           ## M12:2,
CharTable_L3_3_2:= CharacterTable("L3(3).2");                                      ## L3(3):2,
CharTable_L2_25 := CharacterTable("SuzM16"); # CharacterTable( "L2(25)" )          ## L2(25),
CharTable_A7    := CharacterTable("SuzM17"); # CharacterTable( "A7" )              ## A7

ClNames_Suz     := ClassNames( CharTable_Suz    );;                                ## names
ClNames_G2_4    := ClassNames( CharTable_G2_4   );;                                ## of conjugacy 
ClNames_SuzM2   := ClassNames( CharTable_SuzM2  );;                                ## classes
ClNames_U5_2    := ClassNames( CharTable_U5_2   );;                                ##
ClNames_SuzM5   := ClassNames( CharTable_SuzM5  );;                                ##
ClNames_SuzM6   := ClassNames( CharTable_SuzM6  );;                                ## 
ClNames_SuzM8   := ClassNames( CharTable_SuzM8  );;                                ##  
ClNames_SuzM10  := ClassNames( CharTable_SuzM10 );;                                ## 
ClNames_L3_3_2  := ClassNames( CharTable_L3_3_2 );;                                ## 
ClNames_L2_25   := ClassNames( CharTable_L2_25  );;                                ##
ClNames_A7      := ClassNames( CharTable_A7     );;                                ##  

NrClasses_G2_4  := Size( ClNames_G2_4  );  #  32                                   ## numbers 
NrClasses_SuzM2 := Size( ClNames_SuzM2 );  #  38                                   ## of conjugacy
NrClasses_U5_2  := Size( ClNames_U5_2  );  #  47                                   ## classes
NrClasses_SuzM5 := Size( ClNames_SuzM5 );  #  24                                   ## 
NrClasses_SuzM6 := Size( ClNames_SuzM6 );  #  27                                   ## 
NrClasses_SuzM8 := Size( ClNames_SuzM8 );  #  38                                   ##
NrClasses_SuzM10:= Size( ClNames_SuzM10);  #  21                                   ##
NrClasses_L3_3_2:= Size( ClNames_L3_3_2 ); #  15                                   ##
NrClasses_L2_25 := Size( ClNames_L2_25 );  #  15                                   ##
NrClasses_A7    := Size( ClNames_A7    );  #   9                                   ##

PosClasses3_G2_4  :=     Filtered( [1..NrClasses_G2_4],                            ## positions
                   n -> OrdersClassRepresentatives( CharTable_G2_4  )[n] = 3  );;  ## of conjugacy classes  
PosClasses3_SuzM2 :=     Filtered([1..NrClasses_SuzM2],                            ## of elements
                   n -> OrdersClassRepresentatives( CharTable_SuzM2 )[n] = 3  );;  ## of order 3 
PosClasses3_U5_2 :=      Filtered([1..NrClasses_U5_2],                             ##
                   n -> OrdersClassRepresentatives( CharTable_U5_2  )[n] = 3  );;  ##
PosClasses3_SuzM5 :=     Filtered([1..NrClasses_SuzM5],                            ##
                   n -> OrdersClassRepresentatives( CharTable_SuzM5 )[n] = 3  );;  ##
PosClasses3_SuzM6 :=     Filtered([1..NrClasses_SuzM6],                            ## 
                   n -> OrdersClassRepresentatives( CharTable_SuzM6 )[n] = 3  );;  ## 
PosClasses3_SuzM8 :=     Filtered([1..NrClasses_SuzM8],                            ## 
                   n -> OrdersClassRepresentatives( CharTable_SuzM8 )[n] = 3  );;  ## 
PosClasses3_SuzM10:=     Filtered([1..NrClasses_SuzM10],                           ## 
                   n -> OrdersClassRepresentatives( CharTable_SuzM10 )[n] = 3  );; ## 
PosClasses3_L3_3_2:=     Filtered([1..NrClasses_L3_3_2],                           ## 
                   n -> OrdersClassRepresentatives( CharTable_L3_3_2 )[n] = 3  );; ## 
PosClasses3_L2_25:=     Filtered([1..NrClasses_L2_25],                             ## 
                   n -> OrdersClassRepresentatives( CharTable_L2_25 )[n] = 3  );;  ## 
PosClasses3_A7    :=     Filtered([1..NrClasses_A7],                               ## 
                   n -> OrdersClassRepresentatives( CharTable_A7 )[n] = 3  );;     ## 


ClNames_G2_4 {PosClasses3_G2_4 };   # [ "3a", "3b" ]                               ## names
ClNames_SuzM2{PosClasses3_SuzM2};   # [ "3a", "3b", "3c", "3d", "3e" ]             ## of conjugacy classes
ClNames_U5_2{PosClasses3_U5_2};     # [ "3a", "3b", "3c", "3d", "3e", "3f" ]       ## of elements
ClNames_SuzM5{PosClasses3_SuzM5};   # [ "3a", "3b", "3c", "3d" ]                   ## of order 3 
ClNames_SuzM6{PosClasses3_SuzM6};   # [ "3a", "3b" ]                               ## 
ClNames_SuzM8{PosClasses3_SuzM8};   # [ "3a", "3b", "3c" ]                         ## 
ClNames_SuzM10{PosClasses3_SuzM10}; # [ "3a", "3b" ]                               ## 
ClNames_L3_3_2{PosClasses3_L3_3_2}; # [ "3a", "3b" ]                               ##
ClNames_L2_25{PosClasses3_L2_25};   # [ "3a" ]                                     ## 
ClNames_A7{PosClasses3_A7};         # [ "3a", "3b" ]                               ## 

PCFs_G2_4  := PossibleClassFusions( CharTable_G2_4,  CharTable_Suz );;             ## possible class fusions
PCFs_SuzM2 := PossibleClassFusions( CharTable_SuzM2, CharTable_Suz );;             ## from maximal
PCFs_U5_2  := PossibleClassFusions( CharTable_U5_2, CharTable_Suz );;              ## subgroups
PCFs_SuzM5 := PossibleClassFusions( CharTable_SuzM5, CharTable_Suz );;             ## into Suz
PCFs_SuzM6 := PossibleClassFusions( CharTable_SuzM6, CharTable_Suz );;             ## 
PCFs_SuzM8 := PossibleClassFusions( CharTable_SuzM8, CharTable_Suz );;             ## 
PCFs_SuzM10:= PossibleClassFusions( CharTable_SuzM10, CharTable_Suz );;            ## 
PCFs_L3_3_2:= PossibleClassFusions( CharTable_L3_3_2, CharTable_Suz );;            ## 
PCFs_L2_25 := PossibleClassFusions( CharTable_L2_25, CharTable_Suz );;             ## 
PCFs_A7    := PossibleClassFusions( CharTable_A7, CharTable_Suz );;                ##

## Printing class fusions of elements of order 3 into Suz :

## 11(a). Fusion from G2(4) to Suz :

for pos in PosClasses3_G2_4 do
   Print( " ", ClNames_G2_4[pos], " -> ", Set( PCFs_G2_4, cf -> ClNames_Suz[ cf[ pos ] ]), "\n"  );
od;

#  3a -> [ "3a" ]
#  3b -> [ "3c" ]

##  Conclusion:  Only 3a of G2(4) fuses to 3A of Suz

## 11(b). Fusion from 3_2.U4(3):2'_3 to Suz :

for pos in PosClasses3_SuzM2 do
   Print( " ", ClNames_SuzM2[pos], " -> ", Set( PCFs_SuzM2, cf -> ClNames_Suz[ cf[ pos ] ]), "\n"  );
od;

#  3a -> [ "3a" ]
#  3b -> [ "3a" ]
#  3c -> [ "3b" ]
#  3d -> [ "3b" ]
#  3e -> [ "3c" ]

## Conclusion:  Only classes 3a and 3b of 3_2.U4(3):2'_3 fuse to 3A of Suz

## 11(c). Fusion from U5(2) to Suz :

for pos in PosClasses3_U5_2 do
   Print( " ", ClNames_U5_2[pos], " -> ", Set( PCFs_U5_2, cf -> ClNames_Suz[ cf[ pos ] ]), "\n"  );
od;

# 3a -> [ "3a" ]
# 3b -> [ "3a" ]
# 3c -> [ "3b" ]
# 3d -> [ "3b" ]
# 3e -> [ "3b" ]
# 3f -> [ "3b" ]

## Conclusion:  Only classes 3a and 3b of U5(2) fuse to 3A of Suz

## 11(d). Fusion from 3^5:M11 to Suz :

for pos in PosClasses3_SuzM5 do
   Print( " ", ClNames_SuzM5[pos], " -> ", Set( PCFs_SuzM5, cf -> ClNames_Suz[ cf[ pos ] ]), "\n"  );
od;

# 3a -> [ "3a" ]
# 3b -> [ "3b" ]
# 3c -> [ "3b" ]
# 3d -> [ "3c" ]

## Conclusion:  Only class 3a of 3^5:M11 fuses to 3A of Suz

## 11(e). Fusion from J2:2 to Suz :

for pos in PosClasses3_SuzM6 do
   Print( " ", ClNames_SuzM6[pos], " -> ", Set( PCFs_SuzM6, cf -> ClNames_Suz[ cf[ pos ] ]), "\n"  );
od;

#  3a -> [ "3a" ]
#  3b -> [ "3c" ]

## Conclusion: Only class 3a of J2:2 fuses to 3A of Suz 

## 11(f). Fusion from (A4 x L3(4)):2 to Suz :

for pos in PosClasses3_SuzM8 do
   Print( " ", ClNames_SuzM8[pos], " -> ", Set( PCFs_SuzM8, cf -> ClNames_Suz[ cf[ pos ] ]), "\n"  );
od;

#  3a -> [ "3c" ] 
#  3b -> [ "3a" ] 
#  3c -> [ "3c" ] 

## Conclusion: Only class 3b of (A4 x L3(4)):2 fuses to 3A of Suz 

## 11(g). Fusion from M12:2 to Suz :

for pos in PosClasses3_SuzM10 do
   Print( " ", ClNames_SuzM10[pos], " -> ", Set( PCFs_SuzM10, cf -> ClNames_Suz[ cf[ pos ] ]), "\n"  );
od;

#  3a -> [ "3b" ]
#  3b -> [ "3c" ]

## Conclusion: No elements of order 3 in M12:2 fuse to 3A of Suz 

## 11(h). Fusion from L3(3):2 to Suz :

for pos in PosClasses3_L3_3_2 do
   Print( " ", ClNames_L3_3_2[pos], " -> ", Set( PCFs_L3_3_2, cf -> ClNames_Suz[ cf[ pos ] ]), "\n"  );
od;

#  3a -> [ "3b" ]
#  3b -> [ "3c" ]

## Conclusion: No elements of order 3 in L3(3):2 fuse to 3A of Suz 


## 11(i). Fusion from L2(25) to Suz :

for pos in PosClasses3_L2_25 do
   Print( " ", ClNames_L2_25[pos], " -> ", Set( PCFs_L2_25, cf -> ClNames_Suz[ cf[ pos ] ]), "\n"  );
od;

#  3a -> [ "3c" ]

## Conclusion: No elements of order 3 in L2(25) fuse to 3A of Suz 


## 11(j). Fusion from A7 to Suz :

for pos in PosClasses3_A7 do
   Print( " ", ClNames_A7[pos], " -> ", Set( PCFs_A7, cf -> ClNames_Suz[ cf[ pos ] ]), "\n"  );
od;

# 3a -> [ "3c" ]
# 3b -> [ "3c" ]

## Conclusion: No elements of order 3 of A7 fuse to 3A of Suz 
###

###
## Section 12.
##
##   Fusion into class 3a of J2 from its maximal subgroups U3(3) and PGL(2,7)
## 


CharTable_J2     := CharacterTable("J2");;                                         ## character tables of J2
CharTable_U3_3   := CharacterTable("J2M1");   # CharacterTable( "U3(3)" )          ## and its maximal subgroups 
CharTable_PGL2_7 := CharacterTable("J2M7");   # CharacterTable( "L3(2).2" )        ## U3(3) and PGL2(7)

ClNames_J2       := ClassNames( CharTable_J2 );;                                   ## names of
ClNames_U3_3     := ClassNames( CharTable_U3_3 );;                                 ## conjugacy 
ClNames_PGL2_7   := ClassNames( CharTable_PGL2_7 );;                               ## classes

NrClasses_J2     := Size( ClNames_J2     );  #   21                                ## numbers 
NrClasses_U3_3   := Size( ClNames_U3_3   );  #   14                                ## of conjugacy
NrClasses_PGL2_7 := Size( ClNames_PGL2_7 );  #    9                                ## classes

PosClasses3_U3_3   :=     Filtered( [1..NrClasses_U3_3],                           ## positions of       
                   n -> OrdersClassRepresentatives( CharTable_U3_3 )[n] = 3  );;   ## conjugacy classes 
PosClasses3_PGL2_7 :=     Filtered([1..NrClasses_PGL2_7],                          ## of elements 
                   n -> OrdersClassRepresentatives( CharTable_PGL2_7 )[n] = 3  );; ## of order 3

ClNames_U3_3  {PosClasses3_U3_3  };  #  [ "3a", "3b" ]                             ## names of conjugacy classes
ClNames_PGL2_7{PosClasses3_PGL2_7};  #  [ "3a" ]                                   ## of elements of order 3

PCFs_U3_3   := PossibleClassFusions( CharTable_U3_3  , CharTable_J2 );;            ## possible class fusions
PCFs_PGL2_7 := PossibleClassFusions( CharTable_PGL2_7, CharTable_J2 );;            ## from maximal subgroups of J2

## Fusion of elements of order 3 of U3(3) into J2 : 

for pos in PosClasses3_U3_3 do
   Print( "  ", ClNames_U3_3[pos], " -> ", Set( PCFs_U3_3, cf -> ClNames_J2[ cf[ pos ] ]), "\n"  );
od;

#  3a -> [ "3a" ]
#  3b -> [ "3b" ]   

##  Conclusion:  Only 3a of U3(3) fuses to 3a of J2

## Fusions of elements of order 3 of PGL2(7) into J2 : 

for pos in PosClasses3_PGL2_7 do
   Print( "  ", ClNames_PGL2_7[pos], " -> ", Set( PCFs_PGL2_7, cf -> ClNames_J2[ cf[ pos ] ]), "\n"  );
od;

#  3a -> [ "3b" ]   ##  Conclusion:  No elements of order 3 of PGL2(7) fuse to 3a of J2
###

###
## Section 13.
##
##  Proving that no (3a,3a)-generated subgroup of G2(4) has order divisible by either 7 or 13.
##  

## Standard generators of G2(4) are a and b, where a is in class 2A, b is in class 5C/D, 
## ab has order 13, abb has order 13, and ababb has order 15.

G2_4 := AtlasGroup("G2(4)");                    ## G2(4)
# <permutation group of size 251596800 with 2 generators>
Gens_G2_4 := GeneratorsOfGroup(G2_4);;
a := Gens_G2_4[1];; b:= Gens_G2_4[2];;          ## standard generators of G2(4)
List( [ a, b, a*b, a*b^2, (a*b)^2*b ], Order );
# [ 2, 5, 13, 13, 15 ]                          ## this agrees with the definition of standard generators

## Constructing a representative of class 3a of G2(4) :

c := (a*b*a*b*b)^5;;     
Order(c);   # 3     
Centr_c := Centralizer(G2_4,c);;                ## Centralizer C(c) in G2(4)
Size(Centr_c);    #  60480                      ## this confirms that c is in class 3a

CnjClass_c := ConjugacyClass( G2_4, c );;       ## conjugacy class of c
Orbs := OrbitsDomain( Centr_c, CnjClass_c );;   ## orbits of C(c) on the conjugacy class of c

NOrbs := Size(Orbs); #  10                      ## number of orbits
List(Orbs,Size);                                ## sizes of orbits
# [ 1008, 945, 945, 1008, 63, 63, 63, 63, 1, 1 ]

2Groups := List( Orbs, o -> 
        Group( c, Representative(o) ) );;      ## representatives of 2-generated subgroups < c, c^g >, g in G2(4)

List(2Groups,Size);  # [ 24, 60, 60, 24, 12, 12, 12, 12, 3, 3 ]

## Conclusion: No (3a,3a)-generated subgroup of G2(4) has order divisible by either 7 or 13.
###

###
## Section 14.
##
##  Proving that no (3a,3a)-generated subgroup of U4(3) has order divisible by 7.
##  

##  Standard generators of U4(3) are a and b where a has order 2, b is in class 6A, ab has order 7 and abababbababb has order 5.

U4_3 := AtlasGroup("U4(3)");                       ## U4(3)
# <matrix group of size 3265920 with 2 generators>
Gens_U4_3 := GeneratorsOfGroup(U4_3);;
a := Gens_U4_3[1];; b:= Gens_U4_3[2];;             ## standard generators
List([ a, b, a*b, (a*b)^3*(b*a)^2*b^2 ], Order);  
#  [ 2, 6, 7, 5 ]                                  ## this agrees with the definition of standard generators

## Constructing a representative of class 3a of U4(3)

c:=b^2;;
Order(c);  # 3
Centr_c := Centralizer(U4_3,c);
Size(Centr_c);  # 5832   ##  => c is in class 3a

## Order of (3a,3a)-generated subgroups:

Conj := ConjugacyClass( U4_3, c );;
Orbs := OrbitsDomain(  Centr_c, Conj );;
NOrbs := Size(Orbs); #  6                           ## number of orbits

2GroupsSizes := List( Orbs, o -> Size( Group( c, Representative(o) ) ) );
# [ 24, 24, 9, 9, 3, 3 ]                            ##  Orders of 2-generated subgroups < c, c^g >, g in U4_3

## Conclusion:  There are no (3a,3a)-generated subgroups in U4(3) of order divisible by 7.
###

###
## Section 15.
## 
##  Proving that no (3a,3a)-generated subgroup of U3(3) has order divisible by 7.
##  

##  Standard generators of U3(3) are a and b where a has order 2, b has order 6 and ab has order 7.

U3_3 := AtlasGroup("U3(3)");;
Gens_U3_3 := GeneratorsOfGroup(U3_3);;
a := Gens_U3_3[1];; b:= Gens_U3_3[2];;             ## standard generators
List( [ a, b, a*b ], Order ); 
# [ 2, 6, 7 ]                                      ## this agrees with the definition of standard generators

## Constructing a representative of class 3a of U3(3)

c := b^2;;
Order(c);                  # 3
Size(Centralizer(U3_3,c)); # 108                      ## => c is in class 3a

Conj := ConjugacyClass(U3_3,c);;
Set(Combinations(Elements(Conj),2),k-> Size(Group(k)));   ##  Sizes of (3a,3a)-generated subgroups of U3(3)
# [ 3, 24 ]

## Conclusion: There are no (3a,3a)-generated subgroups in U3(3) of order divisible by 7
###

###
## Section 16.
##
##  Analysing class sizes of elements of order 3 
##  in the maximal subgroup M = 3_2.U4(3):2'_3 of Suz
##  and in its sections 3_2.U4(3)  and  U4(3) :
##

CharTable_SuzM2    := CharacterTable("SuzM2");  # CharacterTable( "3_2.U4(3).2_3'" )    ## character 
CharTable_3_2_U4_3 := CharacterTable("3_2.U4(3)");;                                     ## tables 
CharTable_U4_3     := CharacterTable("U4(3)");;                                         ##

ClNames_SuzM2      := ClassNames( CharTable_SuzM2 );;               ## names 
ClNames_3_2_U4_3   := ClassNames( CharTable_3_2_U4_3 );;            ## of conjugacy 
ClNames_U4_3       := ClassNames( CharTable_U4_3 );;                ## classes

NrClasses_SuzM2    := Size( ClNames_SuzM2 );     # 38               ## numbers 
NrClasses_3_2_U4_3 := Size( ClNames_3_2_U4_3 );  # 46               ## of conjugacy 
NrClasses_U4_3     := Size( ClNames_U4_3 );      # 20               ## classes

PosClasses3_SuzM2 := Filtered( [1..NrClasses_SuzM2],                ## positions 
   n -> OrdersClassRepresentatives(CharTable_SuzM2)[n] = 3  );;     ## of classes  
PosClasses3_3_2_U4_3 := Filtered( [1..NrClasses_3_2_U4_3],          ## of elements
   n -> OrdersClassRepresentatives(CharTable_3_2_U4_3)[n] = 3  );;  ## of order 3 
PosClasses3_U4_3 := Filtered( [1..NrClasses_U4_3],                  ##
   n -> OrdersClassRepresentatives(CharTable_U4_3)[n] = 3  );;      ##

 SizesCClasses3_SuzM2 := List( PosClasses3_SuzM2, pos 
            ->  SizesConjugacyClasses(CharTable_SuzM2)[pos] );;     ## list of sizes 
 SizesCClasses3_3_2_U4_3 := List( PosClasses3_3_2_U4_3, pos         ## of conjugacy classes
            ->  SizesConjugacyClasses(CharTable_3_2_U4_3)[pos] );;  ## of elements
 SizesCClasses3_U4_3 := List( PosClasses3_U4_3, pos                 ## of order 3 
            ->  SizesConjugacyClasses(CharTable_U4_3)[pos] );;      ## 


## Printing class sizes for M = 3_2.U4(3):2'_3 :

for n in [ 1..Size(PosClasses3_SuzM2) ] do 
    Print("Class : ", ClNames_SuzM2[PosClasses3_SuzM2[n]],
          "   Size : ", PrintString(SizesCClasses3_SuzM2[n],6), "\n" );
od;

# Class : 3a   Size :      2
# Class : 3b   Size :    560
# Class : 3c   Size :   1120
# Class : 3d   Size :  20160
# Class : 3e   Size : 120960

## Conclusion: Class 3a lies in the 3-radical 3_2 of M. Hence, if x,y ∊ 3a, they cannot generate a subgroup of order divisible by 7


## Printing class sizes for 3_2.U4(3) :

for n in [ 1..Size(PosClasses3_3_2_U4_3) ] do 
    Print("Class : ", ClNames_3_2_U4_3[PosClasses3_3_2_U4_3[n]],
          "   Size : ", PrintString(SizesCClasses3_3_2_U4_3[n],6), "\n" );
od;

# Class : 3a   Size :      1
# Class : 3b   Size :      1
# Class : 3c   Size :    560
# Class : 3d   Size :    560
# Class : 3e   Size :    560
# Class : 3f   Size :  10080
# Class : 3g   Size :  10080
# Class : 3h   Size : 120960

## Conclusion : From the class sizes, we see that class 3b of M = 3_2.U4(3):2'_3 is one 
##              of the classes 3c, 3d, 3e of 3_2.U4(3) and that the other two are merged to 3c of M
##              by the outer automorphism 2'_3. ( In fact, from class fusion, we may determine
##              precisely that 3c of 3_2.U4(3) is 3b of M and 3d and 3e of 3_2.U4(3) merge to 3c of M : 
##
##              PCFs := PossibleClassFusions( CharTable_3_2_U4_3, CharTable_SuzM2 );;
##              Set( PCFs, cf -> ClNames_SuzM2[cf[CharTable_3_2_U4_3.3c ]]); # [ "3b" ] ## fusion of 3c into M
##              Set( PCFs, cf -> ClNames_SuzM2[cf[CharTable_3_2_U4_3.3d ]]); # [ "3c" ] ## fusion of 3d into M
##              Set( PCFs, cf -> ClNames_SuzM2[cf[CharTable_3_2_U4_3.3e ]]); # [ "3c" ] ## fusion of 3e into M
## 
##              However, we do not need this precise information in the proof. )


## Printing class sizes for U4(3) :

for n in [ 1..Size(PosClasses3_U4_3) ] do 
    Print("Class : ", ClNames_U4_3[PosClasses3_U4_3[n]],
          "   Size : ", PrintString(SizesCClasses3_U4_3[n],6), "\n" );
od;

# Class : 3a   Size :    560
# Class : 3b   Size :   3360
# Class : 3c   Size :   3360
# Class : 3d   Size :  40320

## Conclusion : Classes 3c, 3d, 3e  of  3_2.U4(3) map to class 3a of U4(3)
###

###
## Section 17.
##
##  Analysing class sizes of elements of order 3 
##  in the maximal subgroup M = ( A4 × L3(4) ) : 2 of Suz
##  as required in the proof of Case (Suz,3A,7)  :

CharTable_SuzM8 := CharacterTable("SuzM8");  # CharacterTable( "(a4xpsl(3,4)):2" ) ## character table of (A4 x L3(4)):2 
ClNames_SuzM8   := ClassNames( CharTable_SuzM8 );;                                 ## names of conjugacy classes
NrClasses_SuzM8 := Size( ClNames_SuzM8 );  #  38                                   ## number of conjugacy classes 

PosClasses3_SuzM8 :=     Filtered([1..NrClasses_SuzM8],                            ## positions of classes
                   n -> OrdersClassRepresentatives( CharTable_SuzM8 )[n] = 3  );;  ## of elements of order 3 

SizesCClasses3_SuzM8 := List( PosClasses3_SuzM8, pos                               ## sizes of classes
            ->  SizesConjugacyClasses(CharTable_SuzM8)[pos] );;                    ## of elements of order 3 

## Printing class sizes for (A4 x L3(4)):2  :

for n in [ 1..Size(PosClasses3_SuzM8) ] do 
    Print("Class : ", ClNames_SuzM8[PosClasses3_SuzM8[n]],
          "   Size : ", PrintString(SizesCClasses3_SuzM8[n],5), "\n" );
od;

Class : 3a   Size :  2240     ##  = size of (a unique) class C2 of elements of order 3 in L3(4)                        <->  elements (1,y), y in C2 
Class : 3b   Size :     8     ##  = size of two classes of elements of order 3 in A4 merged to C1 by outer involution  <->  elements (x,1), x in C1
Class : 3c   Size : 17920     ##  = product of the above                                                               <->  elements (x,y), x in C1, y in C2 
  
## Conclusion: The whole class 3b  of  ( A4 × L3(4) ) : 2  = SuzM8 generates 
##             the normal subgroup A4 whose order is not divisible by 7
###

###
## Section 18.
##
##  Finding a representative of class 3a of U5(2).2 and checking whether 
##  every (3a,3a,3a)-generated subgroup of U5(2).2 has order not divisible by 11
##  as claimed in the proof of Case (Suz,3A,11) :

## Standard generators of U5(2).2 are a and b, where a has order 2 (so is in class 2C), 
## b has order 4 (so is in class 4D), ab has order 11 and ababb has order 4.

U5_2_2 := AtlasGroup("U5(2).2");                           ## U5(2).2
# <permutation group of size 27371520 with 2 generators>
Gens_U5_2_2 := GeneratorsOfGroup(U5_2_2);;
a := Gens_U5_2_2[1];; b:= Gens_U5_2_2[2];;                 ## standard generators
List( [ a, b, a*b, (a*b)^2*b ], Order );  
#  [ 2, 4, 11, 4 ]                                         ## this agrees with the definition of standard generators


c := (a*b*(a*b^2)^2)^4;;
Order(c);                # 3
Centr_c := Centralizer(U5_2_2,c);;            ## centraliser C of c
Size(Centr_c);          # 77760               ## => c is in class 3a of  U5(2).2 
Conj := ConjugacyClass( U5_2_2, c );;         ## conjugacy class of c


Orbs := OrbitsDomain(  Centr_c, Tuples(Conj,2), OnTuples );;   ##  Orbits of C on pairs (g,h) with g,h in 

3GroupsSizes := Set( Orbs, o -> 
     Size( Group( Concatenation([c], Representative(o) ) ) )); ##  Orders of 3-generated subgroups < c, c^g, c^h >, g,h in U5_2_2

# [ 3, 9, 24, 27, 72, 648, 768 ]       ## distinct orders of these subgroups are {2,3}-numbers

## Conclusion : All orders of (3a,3a,3a)-generated subgroups of U5(2).2
##              are {2,3}-numbers, hence, not divisible by 11
###


###
## Section 19.
##
##  Checking that class 3a of the maximal subgroup 3^5:M11 of Suz lies in its 3-radical
##  as claimed in the proof of Case (Suz,3A, 11)  


Display(CharTable_SuzM5);

#   3^5:M11
#   
#         2   4    3   2   4   2   2  3  2  1  .  1  1  3   2  .   .   .  1   1   1  3  3   .   .
#         3   7    7   7   4   4   4  3  3  4  4  3  3  1   1  1   1   1  2   2   2  .  .   .   .
#         5   1    1   .   .   .   .  .  .  .  .  .  .  .   .  1   1   1  .   .   .  .  .   .   .
#        11   1    .   .   .   .   .  .  .  .  .  .  .  .   .  .   .   .  .   .   .  .  .   1   1
#   
#            1a   3a  3b  2a  6a  6b 6c 6d 3c 3d 9a 9b 4a 12a 5a 15a 15b 6e 18a 18b 8a 8b 11a 11b
#        2P  1a   3a  3b  1a  3b  3b 3a 3b 3c 3d 9b 9a 2a  6c 5a 15a 15b 3c  9b  9a 4a 4a 11b 11a
#        3P  1a   1a  1a  2a  2a  2a 2a 2a 1a 1a 3b 3b 4a  4a 5a  5a  5a 2a  6b  6a 8a 8b 11a 11b
#        5P  1a   3a  3b  2a  6b  6a 6c 6d 3c 3d 9b 9a 4a 12a 1a  3a  3a 6e 18b 18a 8b 8a 11a 11b
#        7P  1a   3a  3b  2a  6a  6b 6c 6d 3c 3d 9a 9b 4a 12a 5a 15b 15a 6e 18a 18b 8b 8a 11b 11a
#       11P  1a   3a  3b  2a  6b  6a 6c 6d 3c 3d 9b 9a 4a 12a 5a 15b 15a 6e 18b 18a 8a 8b  1a  1a
#       13P  1a   3a  3b  2a  6a  6b 6c 6d 3c 3d 9a 9b 4a 12a 5a 15b 15a 6e 18a 18b 8b 8a 11b 11a
#   
#   X.1       1    1   1   1   1   1  1  1  1  1  1  1  1   1  1   1   1  1   1   1  1  1   1   1
#   X.2      10   10  10   2   2   2  2  2  1  1  1  1  2   2  .   .   . -1  -1  -1  .  .  -1  -1
#   X.3      10   10  10  -2  -2  -2 -2 -2  1  1  1  1  .   .  .   .   .  1   1   1  G -G  -1  -1
#   X.4      10   10  10  -2  -2  -2 -2 -2  1  1  1  1  .   .  .   .   .  1   1   1 -G  G  -1  -1
#   X.5      11   11  11   3   3   3  3  3  2  2  2  2 -1  -1  1   1   1  .   .   . -1 -1   .   .
#   X.6      16   16  16   .   .   .  .  . -2 -2 -2 -2  .   .  1   1   1  .   .   .  .  .   H  /H
#   X.7      16   16  16   .   .   .  .  . -2 -2 -2 -2  .   .  1   1   1  .   .   .  .  .  /H   H
#   X.8      44   44  44   4   4   4  4  4 -1 -1 -1 -1  .   . -1  -1  -1  1   1   1  .  .   .   .
#   X.9      45   45  45  -3  -3  -3 -3 -3  .  .  .  .  1   1  .   .   .  .   .   . -1 -1   1   1
#   X.10     55   55  55  -1  -1  -1 -1 -1  1  1  1  1 -1  -1  .   .   . -1  -1  -1  1  1   .   .
#   X.11    110  -25   2  14  -4  -4 -1  2  2  2 -1 -1  2  -1  .   .   .  2  -1  -1  .  .   .   .
#   X.12    110  -25   2  -2  -2  -2  7 -2  2  2 -1 -1  2  -1  .   .   . -2   1   1  .  .   .   .
#   X.13    110  -25   2   6   A  /A  3  .  2  2 -1 -1 -2   1  .   .   .  .   E  -E  .  .   .   .
#   X.14    110  -25   2   6  /A   A  3  .  2  2 -1 -1 -2   1  .   .   .  .  -E   E  .  .   .   .
#   X.15    132   24  -3  12   3   3  . -3  6 -3  .  .  .   .  2  -1  -1  .   .   .  .  .   .   .
#   X.16    220  -50   4 -12   6   6 -6  .  4  4 -2 -2  .   .  .   .   .  .   .   .  .  .   .   .
#   X.17    396   72  -9 -12  -3  -3  .  3  .  .  .  .  .   .  1   D  /D  .   .   .  .  .   .   .
#   X.18    396   72  -9 -12  -3  -3  .  3  .  .  .  .  .   .  1  /D   D  .   .   .  .  .   .   .
#   X.19    440 -100   8   8   B  /B -4  2 -1 -1  C /C  .   .  .   .   . -1   F  /F  .  .   .   .
#   X.20    440 -100   8  -8  -B -/B  4 -2 -1 -1  C /C  .   .  .   .   .  1  -F -/F  .  .   .   .
#   X.21    440 -100   8  -8 -/B  -B  4 -2 -1 -1 /C  C  .   .  .   .   .  1 -/F  -F  .  .   .   .
#   X.22    440 -100   8   8  /B   B -4  2 -1 -1 /C  C  .   .  .   .   . -1  /F   F  .  .   .   .
#   X.23    528   96 -12   .   .   .  .  .  6 -3  .  .  .   . -2   1   1  .   .   .  .  .   .   .
#   X.24    660  120 -15  12   3   3  . -3 -6  3  .  .  .   .  .   .   .  .   .   .  .  .   .   .
#   
#   A = 6*E(3)
#     = -3+3*Sqrt(-3) = 6b3
#   B = -2*E(3)+4*E(3)^2
#     = -1-3*Sqrt(-3) = -1-3i3
#   C = -2*E(3)+E(3)^2
#     = (1-3*Sqrt(-3))/2 = -1-3b3
#   D = -E(15)^7-E(15)^11-E(15)^13-E(15)^14
#     = (-1+Sqrt(-15))/2 = b15
#   E = E(3)-E(3)^2
#     = Sqrt(-3) = i3
#   F = -E(3)^2
#     = (1+Sqrt(-3))/2 = 1+b3
#   G = E(8)+E(8)^3
#     = Sqrt(-2) = i2
#   H = E(11)+E(11)^3+E(11)^4+E(11)^5+E(11)^9
#     = (-1+Sqrt(-11))/2 = b11

## It follows from the character values on classes 3a and 3b that
## the first 10 characters are unfaithful with classes 3a and 3b 
## in their kernels (the lifts of irreducible characters of M11).
## Hence, these classes lie in the 3-radical of 3^5:M11
###

###  
## Section 20.
##
## Case  (S,x,r) = (J₂,3A,7).
##
## We check that no (3A,3A)-generated subgroup of J₂ has order divisible by 7.
## First, we find a representative of class 3A of J₂.
## Standard generators of J₂ are a and b where a is in class 2B, b is in class 3B, ab has order 7 and ababb has order 12.

J2 := AtlasGroup("J2");  # <permutation group of size 604800 with 2 generators>
Gens_J2 := GeneratorsOfGroup(J2);;
a := Gens_J2[1];; b:= Gens_J2[2];;         ## standard generators
List( [ a, b, a*b, a*b*a*b*b ], Order );   
#  [ 2, 3, 7, 12 ]                         ## this agrees with the definition of standard generators

c := (a*b*a*b*b)^4;;

Order(c);               #  3
Centr_c := Centralizer(J2,c);;               ## centraliser C of c in J2 
Size(Centr_c);          #  1080              ##  =>  c is in 3A. 
Conj := ConjugacyClass(J2,c);;               ## conjugacy class of c in J2
  
Orbs := OrbitsDomain( Centr_c, Conj );;      ## orbits of C on the conjugacy class
NOrbs := Size(Orbs);    #  10                ## number of orbits

2GroupsSizes := Set( Orbs, o -> Size( Group( c, Representative(o) ) ) ); ## the set of orders of 2-generated subgroups < c, c^g >, g ∊ J2
# [ 3, 12, 24, 60 ]

## Conclusion : No (3A,3A)-generated subgroup of J2 has order divisible by 7
##              Therefore,   β_{J₂,7}(3A) = 3
###

###  
## Section 21.
##
## Case  (S,x,r) = (HS,4A,11)
##
## We check that all (4A,4A)-generated subgroups of HN have order not divisible by 11
## First, we find a representative of class 4A of HS
## Standard generators of HS are a and b where a is in class 2A, b is in class 5A and ab has order 11

HS := AtlasGroup("HS");   #  <permutation group of size 44352000 with 2 generators>
Gens_HS := GeneratorsOfGroup(HS);;
a := Gens_HS[1];; b:= Gens_HS[2];;       ## standard generators
List( [ a, b, a*b ], Order );        
#  [ 2, 5, 11 ]                          ## this agrees with the definition of standard generators

c := (a*b*a*b^3*a*b^3)^3;;
Order(c);                # 4
Centr_c := Centralizer(HS,c);;            ## centraliser C of c in HS
Size(Centr_c);           # 3840           ##  =>  c is in class 4A 
Conj := ConjugacyClass(HS,c);;            ## conjugacy class of c in HS
Size(Conj);              # 11550

Orbs := OrbitsDomain( Centr_c, Conj );;   ## orbits of C on the conjugacy class
NOrbs := Size(Orbs);     #  17            ## number of orbits

2GroupsSizes := Set( Orbs, o -> Size( Group( c, Representative(o) ) ) ); ## the set of orders of 2-generated subgroups < c, c^g >, g ∊ HS
# [ 4, 16, 20, 24, 120, 320, 500, 720, 5040 ]

## Conclusion : No (4A,4A)-generated subgroup of HS has order divisible by 11
##              Therefore,   β_{HS,11}(4A) = 3
###

###  
## Section 22.
##
##  Case  (S,x) = (McL,3A),  r = 7,11
##
## We check that all (3A,3A)-generated subgroups of McL have orders not divisible by 7 and 11
## First, we find a representative of 3A of McL
## Standard generators of the McLaughlin group McL are a and b where a is in class 2A, b is in class 5A, 
## ab has order 11 and ababababbababbabb has order 7

McL := AtlasGroup("McL");  # <permutation group of size 898128000 with 2 generators>
Gens_McL := GeneratorsOfGroup(McL);;
a := Gens_McL[1];; b:= Gens_McL[2];;                       ## standard generators
List( [ a, b, a*b, (a*b)^4*(b*a)^2*b^2*a*b^2 ], Order );   
#  [ 2, 5, 11, 7 ]                                         ## this agrees with the definition of standard generators

c := (a*b^2)^4;;
Order(c);                       #  3
Centr_c := Centralizer(McL,c);
Size(Centr_c);                  #  29160   ## => c is in class 3A   
Conj := ConjugacyClass(McL,c);;
Size(Conj);                     #  30800

Orbs := OrbitsDomain( Centr_c, Conj );;
NOrbs := Size(Orbs);            #  10      ## number of orbits

2GroupsSizes := Set( Orbs, o -> Size( Group( c, Representative(o) ) ) );  ## the set of orders of 2-generated subgroups < c, c^g >, g ∊ McL
#  [ 3, 9, 24, 120, 375 ]                  ## not divisible by 7 or 11

## Conclusion : No (3A,3A)-generated subgroup of McL has order divisible by either 7 or 11
##              Therefore,   β_{McL,r}(3A) = 3,  r = 7, 11
###

### END ###
###########
