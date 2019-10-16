using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PanAway : MonoBehaviour
{
    public bool startPan;
    private float startTimer;
    public float journeyDistance;

    public float moveSpeed = 1f;


    public Transform moveLocation;
    private Transform startLocation;

    void Awake()
    {
        startPan = false;
        startLocation = transform;
    }

    public void StartJourney()
    {
        startPan = true;
        startTimer = Time.time;
        journeyDistance = Vector3.Distance(moveLocation.position, startLocation.position);
    }

    // Update is called once per frame
    void Update()
    {
        if (startPan)
        {
            float distanceCovered = (Time.time - startTimer) * moveSpeed;

            float distanceSoFar = distanceCovered / journeyDistance;

            transform.position = Vector3.Lerp(startLocation.position, moveLocation.position, distanceSoFar);

            if (distanceCovered >= journeyDistance)
            {
                startPan = false;
            }
        }
    }
}
