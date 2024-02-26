# This file contains tests for functions in NotesFunctions.ps1

# Import required modules
Import-Module -Name Pester

# Import the code file containing the functions to test
BeforeAll {
    . $PSScriptRoot/../App/NotesFunctions.ps1
}

# Test suite for Add-Note function
Describe "Add-Note Function Tests" {
    BeforeEach {
        # Initialise arrays before each test
        $Script:Notes = @()
        $Script:NotesCategories = @()
    }

    It "Adding a note with a specified category should add a note with the specified category to the notes and categories arrays" {
        Add-Note "Test Note" "TestCategory"
        $Notes[-1] -eq "Test Note" -and $NotesCategories[-1] -eq "TestCategory"
    }
}

# Test suite for Edit-Note function
Describe "Edit-Note Function Tests" {
    BeforeEach {
        # Initialise arrays before each test
        $Script:Notes = @("Existing Note 1", "Existing Note 2")
        $Script:NotesCategories = @("Category A", "Category B")
    }

    It "Editing a note in the notes array should modify the note content at the specified index" {
        $Index = 0
        $NewContent = "Edited Note"
        Edit-Note -Index $Index
        $Notes[$Index] -eq $NewContent
    }
}

# Test suite for Clear-Notes function
Describe "Clear-Notes Function Tests" {
    BeforeEach {
        # Initialise arrays before each test
        $Script:Notes = @("Existing Note 1", "Existing Note 2")
        $Script:NotesCategories = @("Category A", "Category B")
    }

    It "Clearing all notes from the notes array should remove all notes and categories from the notes and categories arrays" {
        Clear-Notes
        $Script:Notes.Count -eq 0 -and $Script:NotesCategories.Count -eq 0
    }
}

# Test suite for Search-Notes function
Describe "Search-Notes Function Tests" {
    BeforeEach {
        # Initialise arrays before each test
        $Script:Notes = @("Test Note 1", "Test Note 2")
        $Script:NotesCategories = @("Category A", "Category B")
    }

    It "Searching for notes containing a specific keyword should return notes containing the specified keyword" {
        $Keyword = "Test"
        $FoundNotes = Search-Notes -Keyword $Keyword
        $FoundNotes -contains "Test Note 1" -and $FoundNotes -contains "Test Note 2"
    }

    It "Searching for notes containing a specific keyword should notify the user when no notes containing the keyword are found" {
        $Keyword = "Nonexistent"
        $NotFoundMessage = "No notes containing the keyword '$Keyword' found."
        $FoundNotes = Search-Notes -Keyword $Keyword
        $FoundNotes -eq $NotFoundMessage
    }
}
