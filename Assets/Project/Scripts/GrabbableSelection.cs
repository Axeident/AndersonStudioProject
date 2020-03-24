using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/// <summary>
/// Respawns and object at it's starting position if it gets too far away from the player
/// </summary>
[RequireComponent(typeof(OVRGrabbable))]
public class GrabbableSelection : MonoBehaviour
{
    private Vector3 spawnpoint;
    /// <summary>
    /// Maximum distance the object can be from the player before it respawns
    /// </summary>
    public float maxDistance = 5f;
    public bool respawning = true;

    /// <summary>
    /// Time object needs to be held before triggering transition
    /// </summary>
    public float targetTime = 3f;
    private float heldTime = 0f;

    /// <summary>
    /// The gameobject link for the next stage
    /// </summary>
    public GameObject leadsTo;

    void Start()
    {
        // sets respawnpoint to the location the object spawns in at
        spawnpoint = this.transform.position;
        if (leadsTo == null)
        {
            Debug.LogError("Touch object is not linked to the next stage");
        }
    }

    
    void Update()
    {
        if (GetComponent<OVRGrabbable>().isGrabbed)
        {
            heldTime += Time.deltaTime;
        }
        else
        {
            heldTime = 0;
        }

        if (heldTime >= targetTime)
        {
            // play animation
            respawning = false;
            leadsTo.SetActive(true);
        }

        // checks if the object is too far away from the player, if so it respawns
        // only happens if the object is respawing
        if (Vector3.Distance(GameObject.FindGameObjectWithTag("Player").transform.position, this.transform.position) > maxDistance && respawning == true)
        {
            gameObject.GetComponent<Rigidbody>().velocity = Vector3.zero;
            this.transform.position = spawnpoint;
        }
    }
}
