# Setup that doesn't depend on anything
domain = document.domain
account = 
  switch domain
    when 'beanspeedtest.com' then 'SOM53efaf579e01e'
    when 'floating-mountain-3389.herokuapp.com' then 'SOM53efb6e502080'
    else 'SOM53ef8788e193b'

$dfdTest = null
didSetup = false
progressCheckerIntervalId = null

CoffeeWifi.SpeedTest = {
  # Return a deferred
  startTest: ->

    # A test is already running!
    if $dfdTest
      return $dfdTest

    $dfdTest = $.Deferred()

    ensureSetup()
    SomApi.startTest()
    progressCheckerIntervalId = setInterval progressChecker, 5000

    $dfdTest
}

onTestCompleted = (results) ->
  console.log "completed!"
  clearInterval progressCheckerIntervalId
  $dfdTest.resolve(results)

onError = (error) ->
  console.log(error.message)
  clearInterval progressCheckerIntervalId
  $dfdTest.fail(error.message)

lastUploadProgress = null
lastResults = {}
onProgress = (progress) ->
  unless finishedEarly
    if progress.type == 'upload'
      lastUploadProgress = progress.percentDone
    lastResults[progress.type] = progress.currentSpeed
    console.log "progress = #{progress.percentDone}", progress
    $dfdTest.notify(progress)

# The download test will scale its payload based on the current speed,
# but the upload test will not.  The upload checker scales based on the download
# speed.  So, if down is much faster than up, the upload speed can be *really*
# freakin slow, to the point of never completing.
#
# We try to detect this by checking every 5 seconds.  If the upload progress
# hasn't advanced more than 5% in the last 5 seconds, let's just return the last
# results we have.
# 
# TODO: factor this logic into a separate object
lastUploadCheckpoint = null
progressChecker = ->
  console.log "checking progress"
  if lastUploadProgress and
    lastUploadProgress != 100 and
    lastUploadProgress - lastUploadCheckpoint < 5

      finishEarly()
      console.log "Really slow upload!"
  lastUploadCheckpoint = lastUploadProgress

finishedEarly = false
finishEarly = ->
  clearInterval progressCheckerIntervalId
  lastResults.finishedEarly = true
  finishedEarly = true
  onTestCompleted( lastResults )

didSetup = false
ensureSetup = ->
  console.log "------ Ensure setup"
  unless didSetup
    console.log "------ Actually Ensure setup"
    didSetup = true

    SomApi.account = account
    SomApi.domainName = domain
    SomApi.config.sustainTime = 1
    SomApi.config.progress.verbose = true

    console.log "setting up ontestcompleted: ", onTestCompleted
    SomApi.onTestCompleted = onTestCompleted
    SomApi.onError = onError
    SomApi.onProgress = onProgress
