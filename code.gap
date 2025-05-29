###
##  This code for GAP ( version 4.14.0 of 2024-12-05 ) accompanies the paper
##  
##  "Refined conjugate generation in sporadic groups"
## 
##  by Danila O. Revin and Andrei V. Zavarnitsine
##
##  Date: May 11, 2025

###
##  The following code can be copy-pasted into a working GAP session.
##  The output of a command is given after a single '#'.
##  A comment is given after a double '#'.


###  
##  The Monster 
##  This section relates to the proof of [ Proposition 1  - check this reference ]
  
OddPrimes_M :=  [ 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 41, 47, 59, 71 ];;     ## odd prime divisors of |M| 

CT_M := CharacterTable( "M" );;

ClassNames_M := ClassNames( CT_M );;                                          ## names of the conjugacy classes of M 
Orders_Reps_M := OrdersClassRepresentatives( CT_M );;                         ## orders of representatives of the conjugacy classes of M

ClassNamePositions_M := Filtered( [ 1..Size( ClassNames_M ) ], 
                        p ->  Orders_Reps_M[p] in OddPrimes_M );              ## positions of classes of M of odd prime order
# [ 4, 5, 6, 11, 12, 19, 20, 34, 45, 46, 57, 63, 76, 77, 97, 105, 106, 127, 139, 140, 152, 153, 169, 170 ]

ClassNames_M{ClassNamePositions_M};                                           ## corresponding class names
# [ "3a", "3b", "3c", "5a", "5b", "7a", "7b", "11a", "13a", "13b", "17a", "19a", "23a", "23b", "29a", "31a", "31b", "41a", "47a", "47b", "59a", "59b", "71a", "71b" ]

PositionsNonZero_2A := Filtered(ClassNamePositions_M, p -> ClassMultiplicationCoefficient( CT_M, CT_M.2a, CT_M.2a, p ) <> 0);   
# [ 4, 6, 11 ]                                                                ## positions of classes pX with nonzero coefficients (2A,2A,pX)

ClassNames_M{PositionsNonZero_2A};                                            ## corresponding class names
# [ "3a", "3c", "5a" ]

Set( Orders_Reps_M{PositionsNonZero_2A} );                                    ## corresponding prime orders
# [ 3, 5 ]
  
PositionsNonZero_2B := Filtered(ClassNamePositions_M, p -> ClassMultiplicationCoefficient( CT_M, CT_M.2b, CT_M.2b, p ) <> 0);   
# [ 4, 5, 6, 11, 12, 19, 20, 34, 45, 46, 57, 63, 97, 127 ]                    ## positions of classes pX with nonzero coefficients (2B,2B,pX)

ClassNames_M{PositionsNonZero_2B};                                            ## corresponding class names
# [ "3a", "3b", "3c", "5a", "5b", "7a", "7b", "11a", "13a", "13b", "17a", "19a", "29a", "41a" ]

Set( Orders_Reps_M{PositionsNonZero_2B} );                                    ## corresponding prime orders
# [ 3, 5, 7, 11, 13, 17, 19, 29, 41 ]

  
##
###
