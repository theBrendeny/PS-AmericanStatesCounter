<#
.SYNOPSIS
  Script that counts how many American states the user correctly inputs and gives results upon finishing
.DESCRIPTION
  Compares an array of states with an instance array to see how many states were named
  Turns the count into a percentage which is then converted into a letter grade
.PARAMETER $input
    Reads user input to the variable $input, which repeats until the user writes "DONE" to $input
.INPUTS
  $input - (American state, NONE, *everything else*)
.OUTPUTS
  Grade (Get-Grade) and final report (End-Game)
.NOTES
  Version:        1.0
  Author:         theBrendeny | https://github.com/theBrendeny
  Creation Date:  22/05/2019
#>

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

## Clear screen
cls

#----------------------------------------------------------[Declarations]----------------------------------------------------------

## Array of American states
$states = @(
    "Alabama", "Alaska", "Arizona", "Arkansas",
    "California", "Colorado", "Connecticut",
    "Delaware", "Florida", "Georgia", "Hawaii",
    "Idaho", "Illinois", "Indiana", "Iowa",
    "Kansas", "Kentucky", "Louisiana",
    "Maine", "Maryland", "Massachussets", "Michigan",
    "Minnesota", "Mississippi", "Missouri", "Montana",
    "Nebraska", "Nevada", "New Hampshire", "New Jersey",
    "New Mexico", "New York", "North Carolina", "North Dakota",
    "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island",
    "South Carolina", "South Dakota", "Tennessee", "Texas",
    "Utah", "Vermont", "Virginia", "Washington",
    "West Virginia", "Wisconsin", "Wyoming"
)

## Instance array
$statesTemp = @()

#-----------------------------------------------------------[Functions]------------------------------------------------------------

## Tells the user the states they have named and counted
function Validate-States () {

    Write-Host "Here are the states you have named:`n"
    Get-States
    Write-Host "`nYou have currently named:"(Get-Count)"states!"

    $statesTemp.count()

}

## Tells the user how many states they missed and counted
function Display-Missing-States () {

    if (Get-Count -eq 50) {
    
        Write-Host "You got all 50 states! You aren't missing any!"

    }

    Write-Host "`nHere are the states you missed:"
    Get-Missing-States
    Write-Host "`nYou missed"(Get-Missing-Count)"states!"

}

## Converts score to a percentage value
function Convert-Score () {

    $getCount = Get-Count
    $percent = ($getCount/50 * 100)
    return $percent

}

#-----------------------------------------------------------[Get methods]---------------------------------------------------------

## Return a letter grade between A-F and S
function Get-Grade () {

    switch (Get-Score) {

    ## % Score             Letter Grade ##
    100                   { $grade = "S" }
    {85..99 -contains $_} { $grade = "A" }
    {70..84 -contains $_} { $grade = "B" }
    {60..69 -contains $_} { $grade = "C" }
    {50..59 -contains $_} { $grade = "D" }
    {35..49 -contains $_} { $grade = "E" }
    {0..35  -contains $_} { $grade = "F" }

    }
    
    return "Your grade is: $($grade)"

}

## Returns the score in percentage value
function Get-Score () {

    Convert-Score($count)

}

## Returns the number of states stored in the instance array
function Get-Count () {

    Set-Count($count)

}

## Returns the number of missing states stored in the instance array
function Get-Missing-Count () {

    Set-Missing-Count($missingCount)

}

## Returns the states stored in the instance array
function Get-States () {

    Set-States($count)

}

## Returns the missing states stored in the instance array
function Get-Missing-States () {

    Set-Missing-States($missingCount)

}

#-----------------------------------------------------------[Set methods]---------------------------------------------------------

## Sets the number of states stored in the instance array
function Set-Count () {

    $count = $states | Where {$statesTemp -contains $_}
    $statesIn = $count
    return $count.Length 

}

# Sets the number of missing states stored in the instance array
function Set-Missing-Count () {

    $missingCount = $states | Where {$statesTemp -notcontains $_}
    $statesIn = $missingCount
    return $missingCount.Length 

}

## Sets the name of states stored in the instance array
function Set-States () {

    $count = $states | Where {$statesTemp -contains $_}
    $statesIn = $count
    return $statesIn

}

## Sets the name of missing states stored in the instance array
function Set-Missing-States () {

    $missingCount = $states | Where {$statesTemp -notcontains $_}
    $statesOut = $missingCount
    return $statesOut

}

#-----------------------------------------------------------[Main methods]--------------------------------------------------------

## Start the game
function Start-Game () {

    $done = $false

    while ($done -eq $false) {

        $input = Read-Host -Prompt "Name an American state OR Type DONE to finish OR Type VIEW to view your current progress"

        if ($input -eq "DONE") { 
            $done = $true
            End-Game 
        }

        elseif ($input -eq "VIEW") {
            Validate-States
        }

        ## Passes the string as an object to the array
        $script:statesTemp += $input

    }

}

## Finishes the game and gives the user results
function End-Game () {

    Write-Host "`nThank you for playing!`n"
               "You named " + (Get-Count) + "/50 states of America`n"
               "Score in percentage: " + (Get-Score) + "%`n"

    Get-Grade
    Post-Game

}

## Post game to display any missing states
function Post-Game () {

    $input = Read-Host "`nDo you want to know what states you missed? (Y/N)"
    
    switch ($input) {
    
        Y { Display-Missing-States }
        N { exit                   }
        ##need to have an else or something to control other inputs
    
    }

}

## Main method
function main () {

Write-Host 
"========================================"
"Name as many American states as you can!"
"========================================"

Start-Game

}

#-----------------------------------------------------------[Execution]------------------------------------------------------------

main
