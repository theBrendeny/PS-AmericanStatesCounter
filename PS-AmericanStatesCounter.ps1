<#
.SYNOPSIS
  Script that counts how many American states the user correctly inputs and gives a letter grade upon finishing
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
  Purpose/Change: None
  
.EXAMPLE
  <Example goes here. Repeat this attribute for more than one example>
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

## Instance array to be compared with $states
[Object[]]$statesTemp = @()

## Test array until I fix the proper empty one
$statesTempTest = @("Wisconsin", "Missouri", "Texas",
                    "Maine", "Virginia", "Hi there"
                    )

#-----------------------------------------------------------[Functions]------------------------------------------------------------

function Validate-States () {

    #$contains = $states | Where {$statesTemp -contains $_}
    #Write-Host $contains

    $states.getType()
    $states.Length
    $statesTemp.getType()
    $statesTemp.Length

    cls

    Get-States
    Get-Count

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

## Returns score in percentage value
function Get-Score () {

    Convert-Score($count)

}

## Returns the score by counted states
function Get-Count () {

    Set-Count($count)

}

function Get-States () {

    Set-States($count)

}

#-----------------------------------------------------------[Set methods]---------------------------------------------------------

## Sets the number of counted states
function Set-Count () {

    ## Filters out words that aren't American states
    $count = $states | Where {$statesTempTest -contains $_}
    $statesIn = $count
    return $count.Length ## Returns number of American states named

}

function Set-States () {

    ## Filters out words that aren't American states
    $count = $states | Where {$statesTempTest -contains $_}
    $statesIn = $count
    return $statesIn ## Returns names of American states named

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

        $statesTemp += $input

    }

}

## Finishes the game and gives the user results
function End-Game () {

    Write-Host "`nThank you for playing!`n"
               "You named " + (Get-Count) + "/50 states of America`n"
               "Score in percentage: " + (Get-Score) + "%`n"

    Get-Grade

}

function main () {

Write-Host 
"========================================"
"Name as many American states as you can!"
"========================================"

Start-Game

}

#-----------------------------------------------------------[Execution]------------------------------------------------------------

main
