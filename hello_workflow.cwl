#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow

# To wrap the CWL tool in a workflow you will still need to specify the inputs and outputs
inputs:
  message: string

outputs: []

steps:
  hello_world_step1:
    in:
      message: message
    out: []
    run:
      # Here is the CWL tool specification embedded in a workflow wrapper
      class: CommandLineTool
      hints:
        DockerRequirement:
          dockerPull: quay.io/wshands/walts_python:latest

        InitialWorkDirRequirement:
          listing:
            - entryname: myscript.py
              entry: |-
                print("$(inputs.message)")

      baseCommand:  ["python", "myscript.py"]
      inputs:
        message:
          type: string
          inputBinding:
            position: 1
      outputs: []

  hello_world_step2:
    in:
      message: message
    out: []
    run:
      # Here is the CWL tool specification imported via a TRS URL
      $import: https://dockstore.org/api/ga4gh/trs/v2/tools/quay.io%2Fwshands%2Fwalts_python/versions/latest/plain-CWL/descriptor//hello_world.cwl

