using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Random = UnityEngine.Random;

public class TargetBehavior : MonoBehaviour
{
    private AgentBehavior _agentBehavior;
    
    // Start is called before the first frame update
    void Start()
    {
        var trainingAreaTransform = transform.parent;
        _agentBehavior = trainingAreaTransform.GetComponentInChildren<AgentBehavior>();
        _agentBehavior.TargetBehavior = this;
        
        Respawn();
    }

    // Update is called once per frame
    void Update()
    {
        transform.Rotate(new Vector3(0,10*Time.deltaTime, 0));
    }

    private void OnTriggerEnter(Collider other)
    {
        HandleCollider(other);
    }

    private void OnTriggerStay(Collider other)
    {
        // required for the case, that the target spawns very close/inside the agent
        HandleCollider(other);
    }

    private void HandleCollider(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            _agentBehavior.CollectedTarget();
            Respawn();
        }
    }

    private void Respawn()
    {
        transform.localPosition = new Vector3(
            Random.Range(-4, 4),
            transform.localPosition.y,
            Random.Range(-4, 4)
        );
    }
}
