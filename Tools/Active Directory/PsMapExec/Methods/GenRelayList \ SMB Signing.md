# GenRelayList / SMB Signing

PsMapExec supports SMB signing checks to determine which specified targets have signing enabled

Output for systems which do not require SMB signing will be stored in $pwd\PME\SMB\SigningNotRequired.txt

# Usage

    PsMapExec -Targets All -Method GenRelayList

# Optional parameters

### 1) Set the Domain for which to run against

    -Domain domain.local

### 2) Only shows results where SMB Singing is not required

    -SuccessOnly
