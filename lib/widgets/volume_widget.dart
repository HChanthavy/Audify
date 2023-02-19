import 'package:flutter/material.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';

class VolumeBar extends StatefulWidget {
  const VolumeBar({super.key});

  @override
  State<VolumeBar> createState() => _VolumeBarState();
}

class _VolumeBarState extends State<VolumeBar> {
  double currentVol = 0.3;

  @override
  void initState() {
    PerfectVolumeControl.hideUI = true;
    Future.delayed(
      Duration.zero,
      () async {
        currentVol = await PerfectVolumeControl.getVolume();
      },
    );

    PerfectVolumeControl.stream.listen(
      (volume) {
        if (mounted) {
          setState(
            () {
              currentVol = volume;
            },
          );
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SliderTheme(
          data: SliderTheme.of(context).copyWith(
            overlayColor: Colors.transparent,
            trackHeight: 2,
            thumbShape: const RoundSliderThumbShape(
              disabledThumbRadius: 4,
              enabledThumbRadius: 4,
            ),
            activeTrackColor: Colors.green.shade600.withOpacity(0.8),
            inactiveTrackColor: Colors.white.withOpacity(0.2),
            thumbColor: Colors.green.shade600,
          ),
          child: Slider(
              min: 0,
              max: 1,
              value: currentVol,
              onChanged: (volume) {
                currentVol = volume;
                PerfectVolumeControl.setVolume(volume);
                setState(() {});
              })),
    );
  }
}
