using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/// <summary>
/// Respawns and object at it's starting position if it gets too far away from the player
/// </summary>
public class GrabbableRespawn : MonoBehaviour
{
    private Vector3 spawnpoint;
    /// <summary>
    /// Maximum distance the object can be from the player before it respawns
    /// </summary>
    public float maxDistance = 5f;
    void Start()
    {
        spawnpoint = this.transform.position;
    }

    void Update()
    {
        if (Vector3.Distance(GameObject.FindGameObjectWithTag("Player").transform.position, this.transform.position) > maxDistance)
        {
            this.transform.position = spawnpoint;
        }
    }
}
