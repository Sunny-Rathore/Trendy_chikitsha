import 'package:flutter/material.dart';
import 'package:videosdk/rtc.dart';
import 'meeting_controls.dart';
import 'participant_tile.dart';

class MeetingScreen extends StatefulWidget {
  final String meetingId;
  final String token;
  final void Function() leaveMeeting;

  const MeetingScreen(
      {Key? key,
        required this.meetingId,
        required this.token,
        required this.leaveMeeting})
      : super(key: key);

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  Map<String, Stream?> participantVideoStreams = {};

  bool micEnabled = true;
  bool webcamEnabled = true;

  void setParticipantStreamEvents(Participant participant) {
    participant.on(Events.streamEnabled, (Stream stream) {
      if (stream.kind == 'video') {
        setState(() => participantVideoStreams[participant.id] = stream);
      }
    });

    participant.on(Events.streamDisabled, (Stream stream) {
      if (stream.kind == 'video') {
        setState(() => participantVideoStreams.remove(participant.id));
      }
    });
  }

  void setMeetingEventListener(Meeting _meeting) {
    setParticipantStreamEvents(_meeting.localParticipant);
    _meeting.on(
      Events.participantJoined,
          (Participant participant) => setParticipantStreamEvents(participant),
    );
    _meeting.on(Events.participantLeft, (String participantId) {
      if (participantVideoStreams.containsKey(participantId)) {
        setState(() => participantVideoStreams.remove(participantId));
      }
    });
    _meeting.on(Events.meetingLeft, () {
      participantVideoStreams.clear();
      widget.leaveMeeting();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MeetingBuilder(
      meetingId: widget.meetingId,
      token: widget.token,
      micEnabled: micEnabled,
      webcamEnabled: webcamEnabled,
      displayName: "Yash Chudasama",
      notification: const NotificationInfo(
          title: "Video SDK",
          message: "Video SDK is sharing screen in the meeting",
          icon: "notification_share"),
      builder: (_meeting) {
        setMeetingEventListener(_meeting);
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Meeting ID: ${widget.meetingId}"),
              MeetingControls(
                onToggleMicButtonPressed: () {
                  micEnabled ? _meeting.muteMic() : _meeting.unmuteMic();
                  micEnabled = !micEnabled;
                },
                onToggleWebcamButtonPressed: () {
                  webcamEnabled
                      ? _meeting.disableWebcam()
                      : _meeting.enableWebcam();
                  webcamEnabled = !webcamEnabled;
                },
                onLeaveButtonPressed: () => _meeting.leave(),
              ),
              ...participantVideoStreams.values
                  .map(
                    (e) => ParticipantTile(
                  stream: e!,
                ),
              )
                  .toList(),
            ],
          ),
        );
      },
    );
  }
}