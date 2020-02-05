using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ObjectMoves : MonoBehaviour
{
    private bool canMove;
    private bool isMoving;
    public float moveSpeed = 1f;


    private Transform moveLocation;
    private Transform startLocation;

    private float startTimer;
    private float journeyDistance;


    void Start()
    {
        canMove = true;
        startLocation = transform;
    }

    public bool CanIMove()
    {
        return canMove;
    }

    public void StartFlight(Transform targetGoal)
    {
        startTimer = Time.time;

        moveLocation = targetGoal;

        journeyDistance = Vector3.Distance(moveLocation.position, startLocation.position);

        isMoving = true;
        canMove = false;
    }

    // Update is called once per frame
    void Update()
    {
        if(isMoving)
        {
            float distanceCovered = (Time.time - startTimer) * moveSpeed;

            float distanceSoFar = distanceCovered / journeyDistance;

            transform.position = Vector3.Lerp(startLocation.position, moveLocation.position, distanceSoFar);

            if(transform.position == moveLocation.position)
            {
                isMoving = false;
            }
        }
    }
}
