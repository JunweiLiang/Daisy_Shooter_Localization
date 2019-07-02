# coding=utf-8
# base class for everything, just store some params
import os

class Daisy:
	def __init__(self):
		self.siteName = "VERA_Shooter_Localization" # the folder of your project under htdocs/
		self.listenPort = 21320
		self.processLogPath = "processLog/" # get a log for every request
		self.tmpPath = "tmp/"
		self.runPath = "runs/" #datasetname/ # this path can be used to reproduce directly
		self.refinePath = "refines/" # refine the er results
		self.hostAddress = "127.0.0.1" # note that this won't work if you redirected second-level path to subdomain URL
		self.progressApi = self.hostAddress+"/%s/index.php/python/progress" % self.siteName # path to update process
		self.junk = [] # path to remember to delete
		self.videoWidth = 720
		self.parallelJob = 5

		self.gunshotRunPath = "gunshotRuns/" # videoname, will have the /segments, /mfccs, /bofs, /predictions.txt, /predictions.png
		self.countGunshotRunPath = "countGunshotRuns/"
		self.getSpecRunPath = "getSpectrogramRuns/"

		self.modelPath = "models/"

		self.gunshotClassificationModellst = "gunshot_classification.noisy_only.model.lst"
		
		# preview img for a video
		self.maxImgHeight = 576
		self.maxImgWidth = 720
		self.imgCount = 6  # how many img for each video
		# full video frame size
		# 720x576 will get 1.2GB for a 8 minute video
		self.frame_shorter_edge_size = 360
		self.frame_max_size = 640

		self.gunshotFeatureExtractionPath = "gunshotFeatures/"

		# modify the following for new deployment
		self.safety = os.environ.get("VERASECRETKEY", "verascretkey")
		self.sfepPath = "/additional_software/sfep_mfcc/"
		self.erCodePath = '/ml_code/AudioSync/'
		self.gunshotCodePath = '/ml_code/GunshotDetection/'
