# BSP6 - Situational understanding of semantic elements in the environment using implicit neural representations for robotics

The code base consists of 3 main sub folders:

  - EmsaNet preprocessor: Given the panoptic segmentation process for foreground objects from Emsanet, the object isolation code can be found in this directory.

  - detectron2: A folder that assumes installation of the detectron 2 library and shows the use of detectron2 for panoptic segmentation within a real time setup.
  
  - pixelnerf: Which is a folder assuming the installation of the pixelNerf library and includes the results and the setup for the NERF reconstruction for chairs and cars.
              - location of all results: ./visuals
  
  - code-nerf: Which assumes the installation of the codeNerf librarby which includes the results and the trained model for the visualization of the NIR convergence.
              - location of all results: ./exps/data/runs/test
 
 - Object id from the ShapeNet data set for evaluations from the main report: bd504539074e453721a08935eb37d792
             
