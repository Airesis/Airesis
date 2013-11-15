class ProposalsWorker
  include ProposalsModule, NotificationHelper, Rails.application.routes.url_helpers
  @queue = :proposals

  ENDTIME='endtime'
  LEFT24='left24'
  LEFT1='left1'
  LEFT24VOTE='left24_vote'
  LEFT1VOTE='left1_vote'

  def self.perform(*args)
    params = args[0]
    case params['action']
      when ENDTIME
        ProposalsWorker.new.end_proposal(params['proposal_id'])
      when LEFT24
        ProposalsWorker.new.left_24(params['proposal_id'])
      when LEFT1
        ProposalsWorker.new.left_1(params['proposal_id'])
      when LEFT24VOTE
        ProposalsWorker.new.left_24_vote(params['proposal_id'])
      when LEFT1VOTE
        ProposalsWorker.new.left_1_vote(params['proposal_id'])
      else
        puts "==Action not found!=="
    end
  end

  #fa terminare la fase di valutazione di una proposta
  def end_proposal(proposal_id)
    proposal = Proposal.find_by_id(proposal_id)
    check_phase(proposal)
  end


  #invia una notifica a tutti i partecipanti alla proposta
  # che non hanno dato la loro valutazione o possono cambiarla
  # 24 ore prima della chiusura del dibattito
  def left_24(proposal_id)
    @proposal = Proposal.find(proposal_id)
    notify_24_hours_left(@proposal)
  end

  #invia una notifica a tutti i partecipanti alla proposta
  # che non hanno dato la loro valutazione o possono cambiarla
  # 1 ora prima della chiusura del dibattito
  def left_1(proposal_id)
    @proposal = Proposal.find(proposal_id)
    notify_1_hour_left(@proposal)
  end


  #send a notification to all partecipants that can vote the proposal and haven't voted it yet
  # 24 ore prima della chiusura del dibattito
  def left_24_vote(proposal_id)
    @proposal = Proposal.find(proposal_id)
    notify_24_hours_left_to_vote(@proposal)
  end

  #send a notification to all partecipants that can vote the proposal and haven't voted it yet
  # 1 ora prima della chiusura del dibattito
  def left_1_vote(proposal_id)
    @proposal = Proposal.find(proposal_id)
    notify_1_hour_left_to_vote(@proposal)
  end

end
