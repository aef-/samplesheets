#!/usr/bin/env cwl-runner

class: CommandLineTool
cwlVersion: v1.0
baseCommand: ["python", "input-to-csv.py"]

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entryname: samples.json
        entry: $(inputs.samples)
      - entryname: input-to-csv.py
        entry: |-
          import json
          import csv
          j = json.load(open('samples.json'))
          f = open('sample_sheet.csv', 'w')
          fieldnames = ['FCID','Lane','SampleID','SampleRef','Index','Description','Control','Recipe','Operator','SampleProject']
          c = csv.DictWriter(f, fieldnames=fieldnames, extrasaction='ignore')
          f.write(",".join(fieldnames) + '\n')
          c.writerows(j)
inputs:
  samples:
    type:
      type: array
      items:
        type: record
        fields:
          Lane:
            type: int
          SampleID:
            type: string
          SampleRef:
            type: string
          Index:
            type: string
          Description:
            type: string
          Control:
            type: string
          Recipe:
            type: string
          Operator:
            type: string
          SampleProject:
            type: string
          DnaInputNg:
            type: Any?
          CaptureInputNg:
            type: Any?
          LibraryVolume:
            type: Any?
          PatientID:
            type: string
          IgoID:
            type: string

outputs:
  sample_sheet:
    type: File
    outputBinding:
      glob: sample_sheet.csv
